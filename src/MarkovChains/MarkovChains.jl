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

# markovchains.jl
AbstractMarkovChain, AbstractStochasticProcess, MarkovChain,

# simulatemarkovchains.jl
rand

# include scripts
include("markovchains.jl")
include("simulatemarkovchains.jl")
end
