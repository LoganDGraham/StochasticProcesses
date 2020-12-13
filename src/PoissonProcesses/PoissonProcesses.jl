"""
    PoissonProcesses

A module for simulating Poisson processes.
"""
module PoissonProcesses
using Distributions: Poisson, rand, Uniform
using StochasticProcesses
using StochasticProcesses.MarkovChains: AbstractMarkovChain

export

# concrete types
PoissonProcess,

# methods
nexpectedarrivals, rand

# include scripts
include("poissonprocesses.jl")
include("simulatepoissonprocesses.jl")  # requires poissonprocesses.jl
end
