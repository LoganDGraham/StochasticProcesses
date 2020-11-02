"""
    Samplers

A module in which we subtype 'Sampleable' to facilitate random draws.
"""
module Samplers
using Distributions: AbstractRNG, Discrete, Multivariate, rand, Sampleable, Univariate
using LightGraphs: AbstractGraph, neighbors, nv, vertices
using StochasticProcesses

export

# elementvectorsamplers.jl
ElementVectorSampler, EVecSampler, rand,

# neighborsamplers.jl
NeighborSampler,

# multisamplers.jl
MultiSampler, nsamplers

# include scripts
include("elementvectorsamplers.jl")
include("neighborsamplers.jl")
include("multisamplers.jl")  # requires neighborsamplers.jl
end
