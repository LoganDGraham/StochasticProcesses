"""
In this brief script, we subtype `Sampleable` to allow random draws from the product
distribution of `n` marginal distributions. That is, rather than sampling just one quantity,
we sample a vector of `n` independent quantities, potentially with different marginal
distributions. We use this module to simulate steps in multi-agent random walks, for
example.
"""

"""
    MultiSampler

A sampler that makes it easy to sample from a vector of independent samplers.

##### Fields
- `samplers::T` : the independent samplers.
"""
struct MultiSampler{T<:AbstractVector{<:Sampleable}} <: Sampleable{Multivariate, Discrete}
    samplers::T
end

"""
    Base.show(io::IO, multisampler::MultiSampler)

Show a `MultiSampler` in a human-friendly manner.
"""
function Base.show(io::IO, multisampler::MultiSampler)
    println(io, typeof(multisampler))
    println(io, " independent samplers: ")
    for sampler in multisampler.samplers
        println(io, "  ", sampler)
    end
end

"""
    MultiSampler(graph::AbstractGraph, nsamplers::Integer) -> MultiSampler

Construct and return a `MultiSampler` with `nsamplers` `NeighborSampler`s defined w.r.t.
`graph`.

##### Complexity
- Time complexity: `O(nsamplers)`.
"""
function MultiSampler(graph::AbstractGraph, nsamplers::Integer)
    return MultiSampler([NeighborSampler(graph, rand(1:nv(graph))) for _ in 1:nsamplers])
end

"""
    Base.rand(rng::AbstractRNG,
              multisampler::MultiSampler{<:AbstractVector{<:NeighborSampler}}) -> (
              Vector{Int})

Draw from each `NeighborSampler` independently and return a vector of the samples.

##### Complexity
- Time complexity: `O(nsamplers)`.

Use this for e.g., simulating multiple-agent random walks on a graph.
"""
function Base.rand(rng::AbstractRNG,
                   multisampler::MultiSampler{<:AbstractVector{<:NeighborSampler}})
    return [rand(sampler) for sampler in multisampler.samplers]
end

"""
    Base.rand(rng::AbstractRNG,
              multisampler::MultiSampler{<:AbstractVector{<:Sampleable}}) -> Vector{Float64}

Draw from each `sampler` independently and return a vector of the samples.

##### Complexity
- Time complexity: `O(nsamplers(multisampler))`.

Use this for e.g., simulating multiple-agent random walks on an integer lattice.
"""
function Base.rand(rng::AbstractRNG,
                   multisampler::MultiSampler{<:AbstractVector{<:Sampleable}})
    # convert to float for type stability
    return [float(rand(sampler)) for sampler in multisampler.samplers]
end

"""
    nsamplers(multisampler::MultiSampler)

Return the number of samplers.

##### Complexity
- Time complexity: `O(1)`.
"""
function nsamplers(multisampler::MultiSampler)
    return length(multisampler.samplers)
end
