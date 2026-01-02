println("----------------")
println("Conformal family")
println("----------------")

@testset "Filter zero" begin
    f = [[-1 => 1], [-1 => 1, -2 => 0], [-1 => 1, -2 => 2, -3 => 0], [-1 => 3, -2 => 0], [-1 => 0, -2 => 2, -3 => 3, -4 => 0, -5 => 0], [-1 => 0, -2 => 0, -3 => 0]]
    filtered_f = [[-1 => 1], [-1 => 1], [-1 => 1, -2 => 2], [-1 => 3], [-2 => 2, -3 => 3], Int[]]
    for (v, filtered_v) in zip(f, filtered_f)
        @test DescendentBasis(v).basis == filtered_v
    end
end

@testset "Level function" begin
    f = [DescendentBasis([-1 => 0, -2 => 1]), DescendentBasis([-1 => 1]), DescendentBasis([-1 => 2]), DescendentBasis(Pair{Int,Int}[]), DescendentBasis([-1 => 0, -2 => 0, -3 => 2]), DescendentBasis([-1 => 1, -2 => 1]), DescendentBasis([-1 => 3])]
    @test ConformalCalculator.level([-1=>1]) == 1
    levelset = [2, 1, 2, 0, 6, 3, 3]
    for (v, level_number) in zip(f, levelset)
        @test ConformalCalculator.level(v) == level_number
    end
end

@testset "To index" begin
    set = [DescendentBasis([-2 => 1]), DescendentBasis([-1 => 2])]
    b = DescendentBasis([-2 => 1])
    @test findfirst(==(b), set) == 1
end

@testset "Is canonical" begin
    @test iscanonical(DescendentBasis(Pair{Int,Int}[])) == true
    @test iscanonical(DescendentBasis([-1 => 1])) == true
    @test iscanonical(DescendentBasis([-2 => 1, -1 => 1])) == true
    @test iscanonical(DescendentBasis([-3 => 1, -1 => 2])) == true
    @test iscanonical(DescendentBasis([-1 => 2, -2 => 1])) == false
    @test iscanonical(DescendentBasis([-1 => 1, -3 => 1])) == false
    @test iscanonical(DescendentBasis([-2 => 2, -1 => 3])) == true
    @test iscanonical(DescendentBasis([-2 => 2, 0 => 3])) == false
    @test iscanonical(DescendentBasis([1 => 1, -4 => 2, -3 => 1])) == false
    @test iscanonical(DescendentBasis([-2 => 1, -1 => 1, -1 => 1])) == false
end

@testset "Canonical basis" begin
    @test canonicalbasis(0) == [DescendentBasis(Pair{Int,Int}[])] == CANONICALBASIS[1]
    @test canonicalbasis(1) == [DescendentBasis([-1 => 1])] == CANONICALBASIS[2]
    @test canonicalbasis(2) == [DescendentBasis([-2 => 1]), DescendentBasis([-1 => 2])] == CANONICALBASIS[3]
    @test canonicalbasis(3) == [DescendentBasis([-3 => 1]), DescendentBasis([-2 => 1, -1 => 1]), DescendentBasis([-1 => 3])]  == CANONICALBASIS[4]
    @test canonicalbasis(4) == [DescendentBasis([-4 => 1]), DescendentBasis([-3 => 1, -1 => 1]), DescendentBasis([-2 => 2]), DescendentBasis([-2 => 1, -1 => 2]), DescendentBasis([-1 => 4])]
    @test canonicalbasis(5) == [DescendentBasis([-5 => 1]), DescendentBasis([-4 => 1, -1 => 1]), DescendentBasis([-3 => 1, -2 => 1]), DescendentBasis([-3 => 1, -1 => 2]), DescendentBasis([-2 => 2, -1 => 1]), DescendentBasis([-2 => 1, -1 => 3]), DescendentBasis([-1 => 5])]
end

@testset "Canonical basis longer" begin
    @test canonicalbasis_plain(6) == [[-6 => 1], [-5 => 1, -1 => 1], [-4 => 1, -2 => 1], [-4 => 1, -1 => 2], [-3 => 2], [-3 => 1, -2 => 1, -1 => 1], [-3 => 1, -1 => 3], [-2 => 3], [-2 => 2, -1 => 2], [-2 => 1, -1 => 4], [-1 => 6]]
    @test canonicalbasis_plain(7) == [[-7 => 1], [-6 => 1, -1 => 1], [-5 => 1, -2 => 1], [-5 => 1, -1 => 2], [-4 => 1, -3 => 1], [-4 => 1, -2 => 1, -1 => 1], [-4 => 1, -1 => 3], [-3 => 2, -1 => 1], [-3 => 1, -2 => 2], [-3 => 1, -2 => 1, -1 => 2], [-3 => 1, -1 => 4], [-2 => 3, -1 => 1], [-2 => 2, -1 => 3], [-2 => 1, -1 => 5], [-1 => 7]]
    @test canonicalbasis_plain(8) == [[-8 => 1], [-7 => 1, -1 => 1], [-6 => 1, -2 => 1], [-6 => 1, -1 => 2], [-5 => 1, -3 => 1], [-5 => 1, -2 => 1, -1 => 1], [-5 => 1, -1 => 3], [-4 => 2], [-4 => 1, -3 => 1, -1 => 1], [-4 => 1, -2 => 2], [-4 => 1, -2 => 1, -1 => 2], [-4 => 1, -1 => 4], [-3 => 2, -2 => 1], [-3 => 2, -1 => 2], [-3 => 1, -2 => 2, -1 => 1], [-3 => 1, -2 => 1, -1 => 3], [-3 => 1, -1 => 5], [-2 => 4], [-2 => 3, -1 => 2], [-2 => 2, -1 => 4], [-2 => 1, -1 => 6], [-1 => 8]]
    @test canonicalbasis_plain(9) == [[-9 => 1], [-8 => 1, -1 => 1], [-7 => 1, -2 => 1], [-7 => 1, -1 => 2], [-6 => 1, -3 => 1], [-6 => 1, -2 => 1, -1 => 1], [-6 => 1, -1 => 3], [-5 => 1, -4 => 1], [-5 => 1, -3 => 1, -1 => 1], [-5 => 1, -2 => 2], [-5 => 1, -2 => 1, -1 => 2], [-5 => 1, -1 => 4], [-4 => 2, -1 => 1], [-4 => 1, -3 => 1, -2 => 1], [-4 => 1, -3 => 1, -1 => 2], [-4 => 1, -2 => 2, -1 => 1], [-4 => 1, -2 => 1, -1 => 3], [-4 => 1, -1 => 5], [-3 => 3], [-3 => 2, -2 => 1, -1 => 1], [-3 => 2, -1 => 3], [-3 => 1, -2 => 3], [-3 => 1, -2 => 2, -1 => 2], [-3 => 1, -2 => 1, -1 => 4], [-3 => 1, -1 => 6], [-2 => 4, -1 => 1], [-2 => 3, -1 => 3], [-2 => 2, -1 => 5], [-2 => 1, -1 => 7], [-1 => 9]]
    @test canonicalbasis_plain(10) == [[-10 => 1], [-9 => 1, -1 => 1], [-8 => 1, -2 => 1], [-8 => 1, -1 => 2], [-7 => 1, -3 => 1], [-7 => 1, -2 => 1, -1 => 1], [-7 => 1, -1 => 3], [-6 => 1, -4 => 1], [-6 => 1, -3 => 1, -1 => 1], [-6 => 1, -2 => 2], [-6 => 1, -2 => 1, -1 => 2], [-6 => 1, -1 => 4], [-5 => 2], [-5 => 1, -4 => 1, -1 => 1], [-5 => 1, -3 => 1, -2 => 1], [-5 => 1, -3 => 1, -1 => 2], [-5 => 1, -2 => 2, -1 => 1], [-5 => 1, -2 => 1, -1 => 3], [-5 => 1, -1 => 5], [-4 => 2, -2 => 1], [-4 => 2, -1 => 2], [-4 => 1, -3 => 2], [-4 => 1, -3 => 1, -2 => 1, -1 => 1], [-4 => 1, -3 => 1, -1 => 3], [-4 => 1, -2 => 3], [-4 => 1, -2 => 2, -1 => 2], [-4 => 1, -2 => 1, -1 => 4], [-4 => 1, -1 => 6], [-3 => 3, -1 => 1], [-3 => 2, -2 => 2], [-3 => 2, -2 => 1, -1 => 2], [-3 => 2, -1 => 4], [-3 => 1, -2 => 3, -1 => 1], [-3 => 1, -2 => 2, -1 => 3], [-3 => 1, -2 => 1, -1 => 5], [-3 => 1, -1 => 7], [-2 => 5], [-2 => 4, -1 => 2], [-2 => 3, -1 => 4], [-2 => 2, -1 => 6], [-2 => 1, -1 => 8], [-1 => 10]]
end

@testset "Canonical basis consistency" begin
    for n in 0:25
        @test iscanonical(canonicalbasis(n))
    end
end

@testset "Once canonicalize" begin
    @test once_canonicalize(DescendentBasis([-1 => 1, -2 => 1])) == Descendent{Float64}(DescendentBasis[DescendentBasis([-3 => 1]), DescendentBasis([-2 => 1, -1 => 1])], [1.0, 1.0])
    @test once_canonicalize(DescendentBasis([-1 => 1, -2 => 1, -1 => 1])) == Descendent{Float64}(DescendentBasis[DescendentBasis([-3 => 1, -1 => 1]), DescendentBasis([-2 => 1, -1 => 2])], [1.0, 1.0])
end

@testset "Descendent getindex" begin
    d = Descendent{Float64}([DescendentBasis(Pair{Int,Int}[]), DescendentBasis([1 => 1]), DescendentBasis([1 => 2]), DescendentBasis([2 => 1]), DescendentBasis([3 => 1]), DescendentBasis([1 => 1, 2 => 1]), DescendentBasis([3 => 1, 2 => 1, 1 => 1])], [0.5, 1.5, 2.0, 2.1, 1.4, 1.3, 0.9])
    @test d[DescendentBasis(Pair{Int,Int}[])] == 0.5
    @test d[DescendentBasis([1 => 2])] == 2.0
    @test d[DescendentBasis([2 => 1])] == 2.1
    @test d[DescendentBasis([3 => 1, 2 => 1, 1 => 1])] == 0.9
end

@testset "Virasoro iterate solver" begin
    @test vira_iter_solver(1 / 2, 1 / 2, 3) == [[[1.0;;]], [[3.0 4.0], [2.25 3.0]], [[4.0 1.0 0.0; 0.0 3.0 9.0], [5.0 6.25 15.0], [4.0 5.0 12.0]]]
end