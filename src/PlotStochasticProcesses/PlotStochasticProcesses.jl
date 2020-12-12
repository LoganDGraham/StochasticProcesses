"""
    PlotStochasticProcesses

This module implements methods for plotting realizations of various stochastic processes.
"""
module PlotStochasticProcesses
using StochasticProcesses
using Plots
using GraphRecipes
using GraphPlot
using LightGraphs: AbstractGraph, nv, vertices
using Distributions: Sampleable
using StochasticProcesses
using StochasticProcesses.RandomWalks: RandomWalk

export

# methods
plot

# include scripts
include("plotrandomwalks.jl")
end
