"""
    MC

An optimized package for efficient Markov chain simulation.

In addition to general Markov chains, we offer special functionality for working with random
walks, in particular.
"""
module MC
export
AbstractMarkovChain, MarkovChain,  # MarkovChains.jl
RandomWalk, randomwalkmc,  # RandomWalks.jl
rand,  # SimulateMarkovChains.jl
MultiRandomWalk, nwalkers,  # MultiRandomWalks.jl
plot  # PlotMarkovChains.jl

# using submodules
using ElementVectorSamplers
using NeighborSamplers
using MultiSamplers
using MarkovChains
using RandomWalks
using MultiRandomWalks
using SimulateMarkovChains
using PlotMarkovChains

end
