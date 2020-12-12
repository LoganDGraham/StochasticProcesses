"""
    StochasticProcesses

A lightweight, efficient package for simulating stochastic processes on various domains.

##### Abstract types
- AbstractMarkovChain
- AbstractStochasticProcess

##### Concrete types
- MarkovChain
- MultiRandomWalk
- RandomWalk

##### Methods
- gridwalk
- nwalkers
- plot
- rand
- randomwalkmc
"""
module StochasticProcesses

export

# abstract types
AbstractMarkovChain, AbstractStochasticProcess,

# concrete types
MarkovChain, MultiRandomWalk, RandomWalk,

# methods
gridwalk, nwalkers, plot, rand, randomwalkmc

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
