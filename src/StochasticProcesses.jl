"""
    StochasticProcesses

A lightweight, efficient package for simulating stochastic processes on various domains.
"""
module StochasticProcesses

export
# MC
# MarkovChains.jl
AbstractMarkovChain, MarkovChain,
# RandomWalks.jl
RandomWalk, randomwalkmc,
# SimulateMarkovChains.jl
rand,
# MultiRandomWalks.jl
MultiRandomWalk, nwalkers,
# PlotMarkovChains.jl
plot

# Submodules
include("MC/MC.jl")
end
