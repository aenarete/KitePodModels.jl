using KitePodSimulator, KiteUtils, Plots

cd("..")

const t_end = 10.0 # simulation time
const dt = 1.0 / se().sample_freq

kcu = KCUState()
init_kcu(kcu, se())

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
    on_timer(kcu)
    push!(depower, get_depower(kcu))
    push!(steering, get_steering(kcu))
end
l = @layout([a; b])
plot(times, depower, layout=l, subplot=1, label = "depower", legend = :bottomright)
plot!(times, depower_set, layout=l, subplot=1, label  = "depower_set")
plot!(times, steering, layout=l, subplot=2, label = "steering", legend = :bottomright)
plot!(times, steering_set, layout=l, subplot=2, label  = "steering_set")
savefig("docs/src/step_response.png")
println("Saved step response in docs/src/step_response.png !")