using Pkg
if ! ("ControlPlots" ∈ keys(Pkg.project().dependencies))
    using TestEnv; TestEnv.activate()
end
using KitePodModels, ControlPlots

set = se("system2.yaml")

t_end = 10.0               # simulation time
dt = 1.0 / set.sample_freq # sampling time
step_size = 0.7
kcu = KCU(set)

times = Float64[]
depower = Float64[]
depower_set = Float64[]
steering = Float64[]
steering_set = Float64[]
rel_depower_offset = set.depower_offset/100.0
for step in 1:Int(round(t_end/dt))
    time = step * dt
    if step < 20
        set_depower_steering(kcu, rel_depower_offset, 0.0)
        push!(depower_set, rel_depower_offset)
        push!(steering_set, 0.0)
    else
        set_depower_steering(kcu, rel_depower_offset+0.24, step_size)
        push!(depower_set, rel_depower_offset+0.24)
        push!(steering_set, step_size)
    end
    push!(times, time)
    KitePodModels.on_timer(kcu)
    push!(depower, get_depower(kcu))
    push!(steering, get_steering(kcu))
end
p = plotx(times, [depower, depower_set], [steering, steering_set]; ylabels=["depower","steering"], 
          labels=[["depower","depower_set"], ["steering", "steering_set"]], fig="step_response KCU2")
display(p)
savefig("docs/src/step_response_kcu2.png")
println("Saved step response in docs/src/step_response.png_kcu2 !")