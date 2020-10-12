"""
    MC

An optimized package for efficient Markov chain simulation.

In addition to general Markov chains, we offer special functionality for working with random
walks, in particular.
"""
module MC

using ElementVectorSamplers
using NeighborSamplers
using MultiSamplers
using MarkovChains
using RandomWalks
using MultiRandomWalks
using SimulateMarkovChains
using PlotMarkovChains

export AbstractMarkovChain, MarkovChain  # MarkovChains.jl
export RandomWalk, randomwalkmc  # RandomWalks.jl
export rand  # SimulateMarkovChains.jl
export MultiRandomWalk, nwalkers  # MultiRandomWalks.jl
export plot  # PlotMarkovChains.jl

end
