"""
This module simulates random walks on grids. In particular, we simulate a collection of
agents walking over a grid graph. Associated plotting and statistics functions are provided.
"""
module GridWalks
using Distributions: Sampleable
using LightGraphs: AbstractGraph, grid
using StochasticProcesses
using StochasticProcesses.RandomWalks
#using StochasticProcesses.PlotStochasticProcesses: plot

"""
    gridwalk(nrows::Integer, ncols::Integer, ntimesteps::Integer,
             initialvertex=rand(1:nrows*ncols)) -> Vector{Int}
"""
function gridwalk(nrows::Integer, ncols::Integer, ntimesteps::Integer,
                  initialvertex=rand(1:nrows*ncols))
    rw = RandomWalk(grid((nrows, ncols)), initialvertex)
    return rand(rw, ntimesteps)
end

function plotgridwalk(nrows::Integer, ncols::Integer, ntimesteps::Integer;
                      method::Symbol = :circular)
    return plot(RandomWalk(grid((nrows,ncols))), ntimesteps; method=method)
end
end
