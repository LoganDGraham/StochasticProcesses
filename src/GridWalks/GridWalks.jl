"""
    GridWalks

This module simulates random walks on grids. In particular, we simulate a collection of
agents walking over a grid graph.
"""
module GridWalks
using Distributions: Sampleable
using LightGraphs: AbstractGraph, grid
using StochasticProcesses
using StochasticProcesses.RandomWalks

export

# gridwalks.jl
gridwalk

# include scripts
include("gridwalks.jl")
end
