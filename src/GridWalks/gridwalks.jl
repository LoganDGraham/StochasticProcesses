"""
    gridwalk(nrows::Integer, ncols::Integer, ntimesteps::Integer,
             initialvertex=rand(1:nrows*ncols)) -> Vector{Int}
"""
function gridwalk(nrows::Integer, ncols::Integer, ntimesteps::Integer,
                  initialvertex=rand(1:nrows*ncols))
    rw = RandomWalk(grid((nrows, ncols)), initialvertex)
    return rand(rw, ntimesteps)
end
