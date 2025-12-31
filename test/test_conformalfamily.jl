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
