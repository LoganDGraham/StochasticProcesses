"""
    PlotStochasticProcesses

This module implement methods for plotting realizations of various stochastic processes.
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

export plot

# include scripts
include("plotmarkovchains.jl")
end
