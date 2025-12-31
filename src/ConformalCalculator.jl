module ConformalCalculator

using LinearAlgebra
export O, HoloPoly, evaluation, derivative, Witt_action, Lie_action, deexponentialize, exp_Lie_action
export partitions, canonicalbasis, Descendent

include("./functionring.jl")
include("./deexponentialize.jl")
include("./conformalfamily.jl")

end
