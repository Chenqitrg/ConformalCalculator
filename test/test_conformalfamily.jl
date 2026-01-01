println("----------------")
println("Conformal family")
println("----------------")

@testset "Filter zero" begin
    f = [[1], [1, 0], [1, 2, 0], [3, 0], [0, 2, 3, 0, 0], [0, 0, 0]]
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
    @test d[Int[1, 0]] == 1.5
    @test d[Int[0, 1]] == 2.1
    @test d[Int[0, 0, 1]] == 0.9
    @test d[Int[4, 0]] == 0.0
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

@testset "Canonical basis" begin
    @test canonicalbasis(0) == [Int[]]
    @test canonicalbasis(1) == [[1]]
    @test canonicalbasis(2) == [[0, 1], [2]]
    @test canonicalbasis(3) == [[0, 0, 1], [1, 1], [3]]
    @test canonicalbasis(4) == [[0, 0, 0, 1], [0, 2], [1, 0, 1], [2, 1], [4]]
end

@testset "Get index" begin
    M = ConformalOperator{Float64}(2, 3, [0.1 1.5 2.1; 0.2 0.4 3.1])
    @test M[[0, 1], [0, 0, 1]] == 0.1
    @test M[[0, 1], [1, 1]] == 1.5
    @test M[[2], [1, 1]] == 0.4
    @test M[[2], [3]] == 3.1
end

@testset "Set index" begin
    M = ConformalOperator{Float64}(2, 3, [0.1 1.5 2.1; 0.2 0.4 3.1])
    M[[0, 1], [0, 0, 1]] = 3.5
    M[[0, 1], [1, 1]] = 15.0
    M[[2], [1, 1]] = 1.3
    M[[2], [3]] = 2.2
    @test M == ConformalOperator{Float64}(2, 3, [3.5 15.0 2.1; 0.2 1.3 2.2])
end

@testset "ConformalOperator addition" begin
    M1 = ConformalOperator{Float64}(2, 2, [1.0 2.0; 3.0 4.0])
    M2 = ConformalOperator{Float64}(2, 2, [0.5 1.5; 2.5 3.5])
    M3 = ConformalOperator{Float64}(2, 2, [1.5 3.5; 5.5 7.5])
    @test M1 + M2 == M3 == M2 + M1
end
