using KitePodModels, KiteUtils
using Test

include("plot_step_response.jl")

@testset "KitePodModels.jl" begin
    KiteUtils.set_data_path("")
    kcu = KCU(se())
    @test get_depower(kcu) ≈ 0.236
    @test get_steering(kcu) ≈ 0.0
    set_depower_steering(kcu, 1.0, 1.0)
    on_timer(kcu)
    @test get_depower(kcu) ≈ 0.23975
    @test get_steering(kcu) ≈ 0.01
    @test calc_alpha_depower(kcu, se().depower_offset/100.0) ≈ 0.0
    @test rad2deg(calc_alpha_depower(kcu, 0.37)) ≈ 20.499517119485063
end

