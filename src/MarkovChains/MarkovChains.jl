"""
    MarkovChains

An optimized package for efficient Markov chain simulation.

In addition to general Markov chains, we offer special functionality for working with random
walks, in particular.
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