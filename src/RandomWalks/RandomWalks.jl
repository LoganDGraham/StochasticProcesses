"""
We define a `RandomWalk` struct herein. This is a discrete-time, discrete-space stochastic
process.
"""
module RandomWalks
using LinearAlgebra: Diagonal
using LightGraphs: AbstractGraph, adjacency_matrix, degree, grid, nv, vertices
using Distributions: Categorical, Distribution, rand, Sampleable
using StochasticProcesses
using StochasticProcesses.MarkovChains
using StochasticProcesses.Samplers

export

# randomwalks.jl
RandomWalk, randomwalkmc,

# multirandomwalks.jl
MultiRandomWalk, nwalkers,

# simulaterandomwalks.jl
rand

# include scripts
include("randomwalks.jl")
include("multirandomwalks.jl")
include("simulaterandomwalks.jl")
end
