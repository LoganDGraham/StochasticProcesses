"""
    PoissonProcesses

A module for simulating Poisson processes.
"""
module PoissonProcesses
using Distributions: Poisson, rand
using StochasticProcesses

export

# concrete types
PoissonProcess,

# methods
rand

# include scripts
include("poissonprocesses.jl")
include("simulatepoissonprocesses.jl")
end
