using KitePodSimulator, KiteUtils
using Test

include("plot_step_response.jl")

@testset "KitePodSimulator.jl" begin
    kcu = KCUState()
    init_kcu(kcu, se())
    @test get_depower(kcu) ≈ 0.236
    @test get_steering(kcu) ≈ 0.0
    set_depower_steering(kcu, 1.0, 1.0)
    on_timer(kcu)
    @test get_depower(kcu) ≈ 0.23975
    @test get_steering(kcu) ≈ 0.01
end

