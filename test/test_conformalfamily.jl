println("----------------")
println("Conformal family")
println("----------------")

@testset "Filter zero" begin
    f = [[1], [1, 0], [1, 2, 0], [3, 0], [0, 2, 3, 0, 0], [0,0,0]]
    filtered_f = [[1], [1], [1, 2], [3], [0, 2, 3], Int[]]
    for (v, filtered_v) in zip(f, filtered_f)
        @test ConformalCalculator.tailview(v) == filtered_v
    end
end

@testset "Level function" begin
    f = [[0, 1], [1], [2], Int[], [0, 0, 2], [1, 1], [3]]
    levelset = [2, 1, 2, 0, 6, 3, 3]
    for (v, level_number) in zip(f, levelset)
        @test ConformalCalculator.level(v) == level_number
    end
end

@testset "Sorting of basis" begin
    f = [[0, 1], [1], [2], Int[], [0, 0, 2], [1, 1]]
    sorted_f = sort(f; by=ConformalCalculator.weight_key)
    @test sorted_f == [Int[], [1], [0, 1], [2], [1, 1], [0, 0, 2]]
end

@testset "Descendent struct" begin
    @test Descendent{Float64}([Int[0, 0], [1, 0], [2, 0, 0], [0, 1], [3, 0, 0], [1, 1, 0], [0, 0, 1, 0, 0]], [0.5, 1.5, 2.0, 2.1, 1.4, 1.3, 0.9]) == Descendent{Float64}([Int64[], [1], [0, 1], [2], [0, 0, 1], [1, 1], [3]], [0.5, 1.5, 2.1, 2.0, 0.9, 1.3, 1.4])
end

@testset "Descendent getindex" begin
    d = Descendent{Float64}([Int[0, 0], [1, 0], [2, 0, 0], [0, 1], [3, 0, 0], [1, 1, 0], [0, 0, 1, 0, 0]], [0.5, 1.5, 2.0, 2.1, 1.4, 1.3, 0.9])
    @test d[Int[1,0]] == 1.5
    @test d[Int[0,1]] == 2.1
    @test d[Int[0,0,1]] == 0.9
    @test d[Int[4,0]] == 0.0
end

@testset "Descendent addition and number multiplication" begin
    d1 = Descendent{Float64}([[0, 0], [1, 0], [2, 0, 0], [0, 1], [3]], [0.5, 1.5, 2.0, 2.2, 4.2])
    d2 = Descendent{Float64}([Int[], [0, 1], [3, 0, 0], [1, 1, 0], [0, 0, 1, 0, 0]], [3.0, 2.1, 1.4, 1.3, 0.9])
    d3 = Descendent{Float64}([Int[], [1], [0, 1], [2], [0, 0, 1], [1, 2], [3]], [0.9, 1.0, 2.1, 2.0, 0.9, 1.1, 4.2])
    d12 = Descendent{Float64}([Int64[], [1], [0, 1], [2], [0, 0, 1], [1, 1], [3]], [3.5, 1.5, 4.3, 2.0, 0.9, 1.3, 5.6])
    @test d1 + d2 ≈ d12 ≈ d2 + d1
    @test d1 + d1 ≈ 2.0 * d1
    @test d2 + d2 ≈ 2.0 * d2
    @test d1 + d2 + d3 ≈ d1 + (d2 + d3) ≈ d3 + (d1 + d2) ≈ d3 + d12
    @test 2.0 * d1 == d1 + d1 == Descendent{Float64}([Int[], [1], [2], [0, 1], [3]], [1.0, 3.0, 4.0, 4.4, 8.4])
    @test 3.0 * d2 ≈ d2 + d2 + d2 ≈ Descendent{Float64}([Int[], [0, 1], [3], [1, 1], [0, 0, 1]], [9.0, 6.3, 4.2, 3.9, 2.7])
end