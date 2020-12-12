"""
    MarkovChains

An optimized module for efficient Markov chain simulation.
"""
module MarkovChains
using Distributions: AbstractRNG, Categorical, Discrete, Multivariate, rand, Sampleable
using LightGraphs: AbstractGraph
using StochasticProcesses
using StochasticProcesses.Samplers

export

# abstract types
AbstractMarkovChain, AbstractStochasticProcess,

# concrete types
MarkovChain,

# methods
rand

# include scripts
include("markovchains.jl")
include("simulatemarkovchains.jl")
end
