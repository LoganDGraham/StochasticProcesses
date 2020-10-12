"""
    MC

An optimized package for efficient Markov chain simulation.

In addition to general Markov chains, we offer special functionality for working with random
walks, in particular.
"""
module MC

export AbstractMarkovChain, MarkovChain  # MarkovChains.jl
export RandomWalk, randomwalkmc  # RandomWalks.jl
export rand  # SimulateMarkovChains.jl
export MultiRandomWalk, nwalkers  # MultiRandomWalks.jl
export plot  # PlotMarkovChains.jl

include("ElementVectorSamplers.jl")
include("NeighborSamplers.jl")
include("MultiSamplers.jl")
include("MarkovChains.jl")
include("RandomWalks.jl")
include("MultiRandomWalks.jl")
include("SimulateMarkovChains.jl")
include("PlotMarkovChains.jl")

end
