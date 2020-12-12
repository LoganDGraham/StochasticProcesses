"""
    NeighborSampler{S<:AbstractGraph, T} <: Sampleable{Univariate, Discrete}

A sampler that makes it easy to sample `vertex`'s neighbors in `graph`.

##### Fields
- `graph::S` : a graph.
- `vertex::T` : a vertex that is in `graph`'s vertex set.
"""
struct NeighborSampler{S<:AbstractGraph, T} <: Sampleable{Univariate, Discrete}
    graph::S
    vertex::T
end

"""
    NeighborSampler(graph::AbstractGraph, vertex::Int; checkargs::Bool = true) -> (
                    NeighborSampler)

Construct a `NeighborSampler`, optionally checking to ensure that the arguments are valid.

##### Complexity
- Time complexity: `O(n)`, when `checkargs == true`; otherwise, `O(1)`.
"""
function NeighborSampler(graph::AbstractGraph, vertex::Int; checkargs::Bool = true)
    # don't check arguments
    !checkargs && return NeighborSampler{typeof(graph)}(graph, vertex)
    # check arguments
    if !(vertex in vertices(graph))
        throw(ArgumentError("The vertex must be in the graph's vertex set."))
    else
        return NeighborSampler{typeof(graph), typeof(vertex)}(graph, vertex)
    end
end

"""
    Base.show(io::IO, neighborsampler::NeighborSampler)

Show an `NeighborSampler` in a human-friendly manner.
"""
function Base.show(io::IO, neighborsampler::NeighborSampler)
    println(io, typeof(neighborsampler))
    println(io, " graph: ", neighborsampler.graph)
    println(io, " vertex: ", neighborsampler.vertex)
end

"""
    Base.rand(rng::AbstractRNG, neighborsampler::NeighborSampler) -> Int

Select and return one of `vertex`'s neighbors uniformly-at-random.
"""
function Base.rand(rng::AbstractRNG, neighborsampler::NeighborSampler)
    vertneighbors = neighbors(neighborsampler.graph, neighborsampler.vertex)
    if !isempty(vertneighbors)
        return rand(vertneighbors)
    # if vertex has no neighbors, then throw an error
    else
        error("vertex has no neighbors.")
    end
end
