using Pkg
if ! haskey(Pkg.installed(), "ControlPlots")
    using TestEnv; TestEnv.activate()
end
using KitePodModels, ControlPlots

const t_end = 10.0 # simulation time
const dt = 1.0 / se().sample_freq

kcu = KCU(se())

# rel_depower_offset = se().depower_offset/100.0
# for step in 1:Int(round(t_end/dt))
#     time = step * dt
#     if step < 20
#         set_depower_steering(kcu, rel_depower_offset, 0.0)
#         push!(depower_set, rel_depower_offset)
#         push!(steering_set, 0.0)
#     else
#         set_depower_steering(kcu, rel_depower_offset+0.5, 0.5)
#         push!(depower_set, rel_depower_offset+0.5)
#         push!(steering_set, 0.5)
#     end
#     push!(times, time)
#     KitePodModels.on_timer(kcu)
#     push!(depower, get_depower(kcu))
#     push!(steering, get_steering(kcu))
# end

rel_depower_min = 0.22
rel_depower_max = 0.60
α_min = calc_alpha_depower(kcu, rel_depower_min)
α_max = calc_alpha_depower(kcu, rel_depower_max)
println("α_min = $(rad2deg(α_min)), α_max = $(rad2deg(α_max))")
