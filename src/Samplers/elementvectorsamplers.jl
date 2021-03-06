"""
    ElementVectorSampler

A sampler that makes it easy to draw signed element vectors (of a specified dimension)
uniformly at random.

Notice that, w.p. `1/2`, each element vector is multiplied by `-1`. This is useful for
implementing random walks.

An `element vector` `e_i` is a vector in which the `i`th element is a `1`, and all other
elements are `0`.

##### Fields
- `dimension::Int` : the dimension (i.e. length) of element vectors.
"""
struct ElementVectorSampler <: Sampleable{Multivariate, Discrete}
    dimension::Int
end

"""
    EVecSampler

Alias for `ElementVectorSampler`
"""
EVecSampler = ElementVectorSampler

"""
    Base.show(io::IO, elementvectorsampler::ElementVectorSampler) -> nothing

Show an `ElementVectorSampler` in a human-friendly manner.
"""
function Base.show(io::IO, elementvectorsampler::ElementVectorSampler)
    println(io, typeof(elementvectorsampler))
    println(io, " dimension: ", elementvectorsampler.dimension)
    return nothing
end

"""
    Base.rand(rng::AbstractRNG, elementvectorsampler::ElementVectorSampler) -> Vector{Int}

Return a vector with a specified `length` and with exactly one element equal to `1`.
"""
function Base.rand(rng::AbstractRNG, elementvectorsampler::ElementVectorSampler)
    vector = zeros(Int, elementvectorsampler.dimension)
    # pick an index to replace with 1 or -1 (uses multiple dispatch)
    vector[rand(1:elementvectorsampler.dimension)] = 1*rand((-1,1))
    return vector
end
