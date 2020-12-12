"""
    GridWalks

This module simulates random walks on grids. We support simulation of a collection of
agents walking over the same grid graph, simultaneously.
"""
module GridWalks
using Distributions: Sampleable
using LightGraphs: AbstractGraph, grid
using StochasticProcesses
using StochasticProcesses.RandomWalks

export

# methods
gridwalk

# include scripts
include("gridwalks.jl")
end
