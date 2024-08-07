using Pkg
if ! haskey(Pkg.installed(), "ControlPlots")
    using TestEnv; TestEnv.activate()
end
using KitePodModels, ControlPlots

const t_end = 10.0 # simulation time
const dt = 1.0 / se().sample_freq

kcu = KCU(se())

const times = Float64[]
const depower = Float64[]
const depower_set = Float64[]
const steering = Float64[]
const steering_set = Float64[]
const rel_depower_offset = se().depower_offset/100.0
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
          labels=[["depower","depower_set"], ["steering", "steering_set"]], fig="step_response")
display(p)
savefig("docs/src/step_response.png")
println("Saved step response in docs/src/step_response.png !")