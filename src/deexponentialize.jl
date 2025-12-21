function Lie_action(ϵ::Vector{E}, f::HoloPoly{R,E}) where {R,E} # TODO: test
    f_temp = zero(R, E)
    for (n, ϵn) in enumerate(ϵ)
        f_temp = f_temp + ϵn * Witt_action(n, f)
    end
    return f_temp
end

function deexponentialize(f::HoloPoly{Int,E}, trunc::Int) where {R,E} # TODO: test
    ϵ = [-f[2]]
    poly = [HoloPoly{R,E}([2], [f[2]])]
    for n in 2:trunc
        poly_last = copy(poly[end])
        for (i, p) in enumerate(poly)
            poly[i] = Lie_action(ϵ[1:i], p) / (n - i + 1)
        end
        p_tot_coeff_np1 = sum(poly)[n+1]
        ϵn = p_tot_coeff_np1 - f[n+1]
        push!(ϵ, ϵn)
        push!(poly, poly_last + HoloPoly{R,E}([n+1], [-ϵn]))
    end
    return ϵ, poly
end