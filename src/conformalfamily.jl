level(v::Vector{Int}) = isempty(v) ? 0 : sum(i * n for (i, n) in enumerate(v))
weight_key(v::Vector{Int}) = (level(v), v)

@views function tailview(v::Vector{Int})
    lastidx = findlast(!iszero, v)
    @show v, lastidx
    lastidx === nothing && return view(v, 1:0)
    return view(v, 1:lastidx)
end

struct Descendent{E}
    basis::Vector{Vector{Int}}
    vector::Vector{E}
    function Descendent{E}(basis::Vector{Vector{Int}}, vector::Vector{E}) where {E}
        perm = sortperm(basis; by = weight_key)
        return new(map(tailview, basis[perm]), vector[perm])
    end
end

function Base.:(==)(f::Descendent{E}, g::Descendent{E}) where {E}
    return f.basis == g.basis && f.vector == g.vector
end