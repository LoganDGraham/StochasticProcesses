"""
    StochasticProcesses

A lightweight, efficient package for simulating stochastic processes on various domains.
"""
module StochasticProcesses

export

# markovchains.jl
AbstractMarkovChain, MarkovChain,

# randomwalks.jl
RandomWalk, randomwalkmc,

# simulatemarkovchains.jl, simulaterandomwalks.jl
rand,

# multirandomwalks.jl
MultiRandomWalk, nwalkers,

# gridwalks.jl
gridwalk,

# plotrandomwalks.jl
plot

# include submodules
include("Samplers/Samplers.jl")
include("MarkovChains/MarkovChains.jl")
include("RandomWalks/RandomWalks.jl")
include("PlotStochasticProcesses/PlotStochasticProcesses.jl")
include("GridWalks/GridWalks.jl")

# use submodules
using .Samplers
using .MarkovChains
using .RandomWalks
using .PlotStochasticProcesses
using .GridWalks
end
