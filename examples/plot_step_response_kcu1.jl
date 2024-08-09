using Pkg
if ! ("ControlPlots" ∈ keys(Pkg.project().dependencies))
    using TestEnv; TestEnv.activate()
end
using KitePodModels, ControlPlots

t_end = 10.0 # simulation time
dt = 1.0 / se().sample_freq

kcu = KCU(se())

times = Float64[]
depower = Float64[]
depower_set = Float64[]
steering = Float64[]
steering_set = Float64[]
rel_depower_offset = se().depower_offset/100.0
for step in 1:Int(round(t_end/dt))
    time = step * dt
    if step < 20
        set_depower_steering(kcu, rel_depower_offset, 0.0)
        push!(depower_set, rel_depower_offset)
        push!(steering_set, 0.0)
    else
        set_depower_steering(kcu, rel_depower_offset+0.5, 0.5)
        push!(depower_set, rel_depower_offset+0.5)
        push!(steering_set, 0.5)
    end
    push!(times, time)
    KitePodModels.on_timer(kcu)
    push!(depower, get_depower(kcu))
    push!(steering, get_steering(kcu))
end
p = plotx(times, [depower, depower_set], [steering, steering_set]; ylabels=["depower","steering"], 
          labels=[["depower","depower_set"], ["steering", "steering_set"]], fig="step_response KCU1")
display(p)
savefig("docs/src/step_response_kcu1.png")
println("Saved step response in docs/src/step_response_kcu2.png !")