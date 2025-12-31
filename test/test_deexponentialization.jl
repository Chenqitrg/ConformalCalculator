println("----------------")
println("Deexponentialize")
println("----------------")


fs = [
    HoloPoly{Int,Float64}([1, 2, 3, 4, 5, 6, 7], [1.0, 4, 6, 4, 1, 0.5, 5.5], O{Int}(8)),
    HoloPoly{Int,Float64}([1, 2, 3, 4, 5, 6, 7], [1.0, 4, 6, 4, 1, 2, 3], O{Int}(8)),
    HoloPoly{Int,Float64}([1, 2, 3, 4], [1.0, 4, 6, 4], O{Int}(6)),
    HoloPoly{Int,Float64}([1, 2, 4, 5], [1.0, 4.5, 6.5, 4], O{Int}(6)),
    HoloPoly{Int,Float64}([1, 3, 4, 7], [1.0, 4.5, 6.5, 4], O{Int}(8)),
    HoloPoly{Int,Float64}([1, 3, 4, 7, 8, 9, 12], [1.0, 4.5, 6.5, 4, 1, 1, 1], O{Int}(15)),
]

@testset "Consistency of exponentialization and deexponentialization" begin
    for f in fs
        for truncdim in 1:20
            println("Designed truncation dimension of Lie generator: $truncdim")
            coeff, trunc = deexponentialize(f, O{Int}(truncdim))
            println("The calculated Witt algebra generator coefficient: $coeff")
            f_reconst = exp_Lie_action(coeff, HoloPoly{Int,Float64}([1], [1.0]); trunc=trunc)
            @test f + O{Int}(truncdim + 1) == f_reconst
        end
    end
end