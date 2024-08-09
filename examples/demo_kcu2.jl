using Pkg
if ! ("ControlPlots" ∈ keys(Pkg.project().dependencies))
    using TestEnv; TestEnv.activate()
end
using KitePodModels, ControlPlots, LaTeXStrings

set = se("system2.yaml")

t_end = 10.0               # simulation time
dt = 1.0 / set.sample_freq # sampling time
kcu = KCU(set)

rel_depower_min = 0.22
rel_depower_max = 0.60
α_min = calc_alpha_depower(kcu, rel_depower_min)
α_max = calc_alpha_depower(kcu, rel_depower_max)
# Calculate the change of the angle between the kite and the last tether segment [rad] 
# as function of the actual rel_depower value. 
# println("α_min = $(rad2deg(α_min)), α_max = $(rad2deg(α_max))")

# plot alpha_depower as function of rel_depower
function plot_alpha_depower(kcu; rel_depower_min=0.22, rel_depower_max=0.60)
    rel_depower = range(rel_depower_min, rel_depower_max, length=100)
    α = zeros(length(rel_depower))
    for i in eachindex(α)
        α[i] = calc_alpha_depower(kcu, rel_depower[i])
    end
    plot(rel_depower, rad2deg.(α); ylabel=L"α_{depower}~[°]", xlabel="rel_depower", fig="α = f(rel_depower)")  
end 

plot_alpha_depower(kcu)