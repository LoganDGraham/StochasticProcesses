"""
    RandomWalk{S,T,U<:Sampleable} <: AbstractMarkovChain

##### Fields
- `statespace::S` : the state-space of the random walk (e.g. an integer lattice or a graph).
- `initialstate::T` : the state at which the random walk begins (at time-step 1).
- `stepsampler::U` : sampler that allows i.i.d. steps to be drawn.
"""
struct RandomWalk{S,T,U<:Sampleable} <: AbstractMarkovChain
    statespace::S
    initialstate::T
    stepsampler::U
end

"""
    Base.show(io::IO, randomwalk::RandomWalk) -> nothing

Show a `RandomWalk` in a human-friendly manner.
"""
function Base.show(io::IO, randomwalk::RandomWalk)
    println(io, typeof(randomwalk))
    println(io, " State Space:")
    println(io, "  ", randomwalk.statespace)
    println(io, " Initial state:")
    println(io, "  ", randomwalk.initialstate)
    println(io, " Sampler that allows i.i.d. steps to be drawn:")
    println(io, "  ", randomwalk.stepsampler)
    return nothing
end

"""
    Base.eltype(randomwalk::RandomWalk) -> DataType

Return the type associated with `randomwalk`'s domain.
"""
function Base.eltype(randomwalk::RandomWalk)
    return typeof(randomwalk.initialstate)
end

"""
    RandomWalk(latticedim::Integer, initialstate=zeros(Int, latticedim),
               stepsampler::Sampleable = ElementVectorSampler(latticedim) -> RandomWalk

Construct and return a `RandomWalk` on the integer lattice with dimension `latticedim`.

##### Complexity
- Time complexity: `O(1)`.
"""
function RandomWalk(latticedim::Integer=1, initialstate=zeros(Int,latticedim),
                    stepsampler::Sampleable = ElementVectorSampler(latticedim))
    latticedim < 1 && throw(ArgumentError("latticedim must be positive."))
    length(initialstate) != latticedim &&
        throw(DimensionMismatch("initial state's length should equal latticedim"))
    if latticedim == 1
        return RandomWalk(Int, initialstate[1], stepsampler)
    else
        return RandomWalk(repeat([Int], latticedim), initialstate, stepsampler)
    end
end

"""
    RandomWalk(graph::AbstractGraph, initialvertex=rand(1:nv(graph));
               checkargs::Bool = true) -> RandomWalk

Construct and return a `RandomWalk` on a graph.

##### Complexity
- Time complexity: `O(n)` when `checkargs == true`; otherwise, `O(1)`.
"""
function RandomWalk(graph::AbstractGraph, initialvertex=rand(1:nv(graph));
                    checkargs::Bool = true)
    if checkargs && !(initialvertex in vertices(graph))
        throw(ArgumentError("initialvertex must be a vertex in graph)."))
    else
        return RandomWalk(graph, initialvertex, NeighborSampler(graph, initialvertex))
    end
end

"""
    randomwalkmc(graph::AbstractGraph, initialvertex=rand(1:nv(graph));
                 checkargs::Bool = true) -> MarkovChain

Construct a `MarkovChain` representation of a random walk by reducing to the `MarkovChain`
API.

Observe that this reduction only works for random walks on finite graphs, for `MarkovChain`
employs a finite transition matrix. If one needs a random walk on an infinite graph, then
use the `RandomWalk` constructor designed to dispatch on `AbstractGraph`s.

##### Complexity
- Time complexity: `O(n)` when `checkargs == true`; otherwise, `O(1)`.
"""
function randomwalkmc(graph::AbstractGraph, initialvertex=rand(1:nv(graph));
                      checkargs::Bool = true)
    if checkargs && !(initialvertex in vertices(graph))
        throw(ArgumentError("initialvertex must be a vertex in graph)."))
    else
        initialdist = zeros(nv(graph))
        initialdist[initialvertex] = 1
        # broadcast division
        return MarkovChain(Diagonal(1 ./ degree(graph))*adjacency_matrix(graph), initialdist)
    end
end
