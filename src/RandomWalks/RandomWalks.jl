"""
    RandomWalks

A module that supports random walks on both integer lattices (of arbitrary finite dimension)
and on graphs.
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
