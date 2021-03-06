"""
    Base.rand(randomwalk::RandomWalk{<:AbstractArray{<:DataType}, <:AbstractArray{<:Real},
                                     <:Sampleable}, ntimesteps::Integer) -> Matrix{Int}

Simulate `randomwalk` for `ntimesteps` time-steps over an integer lattice, returning one
sample path (i.e. trajectory) of length `ntimesteps`.

The time steps represented in the sample path are `0, 1, ..., ntimesteps-1`, for we start
with an initial state.

##### Complexity
- Time complexity: `O(n)`.
"""
function Base.rand(randomwalk::RandomWalk{<:AbstractArray{<:DataType},
                                          <:AbstractArray{<:Real},
                                          <:Sampleable}, ntimesteps::Integer)
    # allocate memory
    realizationmatrix = Matrix{Int}(undef, ntimesteps,
                                                   length(randomwalk.initialstate))
    realizationmatrix[1,:] = randomwalk.initialstate
    # draw a random step
    change = rand(randomwalk.stepsampler)
    for step in 2:ntimesteps
        realizationmatrix[step,:] = realizationmatrix[step-1,:] + change
        change = rand(randomwalk.stepsampler)
    end
    return realizationmatrix
end

"""
    Base.rand(randomwalk::RandomWalk{<:DataType, <:Real, <:Sampleable,
              ntimesteps::Integer) -> Vector{Int}

Simulate a one-dimensional `randomwalk` for `ntimesteps` time-steps, returning one sample
path (i.e. trajectory) of length `ntimesteps`.

The time steps represented in the sample path are `0, 1, ..., ntimesteps-1`, for we start
with an initial state.

##### Complexity
- Time complexity: `O(n)`.
"""
function Base.rand(randomwalk::RandomWalk{<:DataType, <:Real, <:Sampleable},
                   ntimesteps::Integer)
    # allocate memory
    realizationvec = Vector{eltype(randomwalk)}(undef, ntimesteps)
    realizationvec[1] = randomwalk.initialstate
    # draw a random step
    change = rand(randomwalk.stepsampler)[1]
    for step in 2:ntimesteps
        realizationvec[step] = realizationvec[step-1] + change
        change = rand(randomwalk.stepsampler)[1]
    end
    return realizationvec
end

"""
    Base.rand(randomwalk::RandomWalk{<:AbstractGraph, <:Integer, <:Sampleable},
              ntimesteps::Integer) -> Vector{Int}

Simulate `randomwalk` for `ntimesteps` time-steps over a graph, returning one sample path
(i.e. trajectory) of length `ntimesteps`.

The time steps represented in the sample path are `0, 1, ..., ntimesteps-1`, for we start
with an initial state.

##### Complexity
- Time complexity: `O(n)`.
"""
function Base.rand(randomwalk::RandomWalk{<:AbstractGraph, <:Integer, <:Sampleable},
                   ntimesteps::Integer)
    # allocate memory
    realizationvec = Vector{eltype(randomwalk)}(undef, ntimesteps)
    realizationvec[1] = randomwalk.initialstate
    for step in 2:ntimesteps
        # draw a neighbor at random
        realizationvec[step] = NeighborSampler(randomwalk.statespace,
                                               realizationvec[step-1]) |> rand
    end
    return realizationvec
end
