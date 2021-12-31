using KitePodSimulator
using Test

cd("..")

@testset "KitePodSimulator.jl" begin
    init_kcu()
    @test get_depower() ≈ 0.236
    @test get_steering() ≈ 0.0
    set_depower_steering(1.0, 1.0)
    on_timer()
    # println("depower: ", get_depower())
    # println("steering: ", get_steering())
    @test get_depower() ≈ 0.23975
    @test get_steering() ≈ 0.01
end
