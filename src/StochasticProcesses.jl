"""
    StochasticProcesses

A lightweight, efficient package for simulating stochastic processes on various domains.

##### Abstract types
- AbstractMarkovChain
- AbstractStochasticProcess

##### Concrete types
- MarkovChain
- MultiRandomWalk
- PoissonProcess
- RandomWalk

##### Methods
- gridwalk
- nexpectedarrivals
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
MarkovChain, MultiRandomWalk, PoissonProcess, RandomWalk,

# methods
gridwalk, nexpectedarrivals, nwalkers, plot, rand, randomwalkmc

# include submodules
include("Samplers/Samplers.jl")
include("MarkovChains/MarkovChains.jl")
include("RandomWalks/RandomWalks.jl")
include("GridWalks/GridWalks.jl")
include("PoissonProcesses/PoissonProcesses.jl")
include("PlotStochasticProcesses/PlotStochasticProcesses.jl")

# use submodules
using .Samplers
using .MarkovChains
using .RandomWalks
using .GridWalks
using .PoissonProcesses
using .PlotStochasticProcesses
end
