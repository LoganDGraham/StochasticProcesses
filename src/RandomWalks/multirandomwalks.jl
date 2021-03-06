"""
We define a `MultiRandomWalk` struct herein. This is a discrete-time, discrete-space
stochastic process. A `MultiRandomWalk` is a `RandomWalk` with multiple agents walking on
the same domain.
"""

"""
    MultiRandomWalk{S,T,U<:Sampleable} <: AbstractMarkovChain

##### Fields
- `domain::S` : the domain within which walkers move (e.g. an integer lattice or a graph).
- `initialstate::T<:AbstractVector` : the state at which the random walk begins (at
time-step 1) -- contains each walker's state.
- `stepsampler::U<:MultiSampler` : sampler that allows i.i.d. steps to be drawn.
"""
struct MultiRandomWalk{S,T<:AbstractVector,U<:MultiSampler} <: AbstractMarkovChain
    domain::S
    initialstate::T
    stepsampler::U
end

"""
    Base.show(io::IO, mrw::MultiRandomWalk) -> nothing

Show a `MultiRandomWalk` in a human-friendly manner.
"""
function Base.show(io::IO, mrw::MultiRandomWalk)
    println(io, typeof(mrw))
    println(io, " Domain:")
    println(io, "  ", mrw.domain)
    println(io, " Number of walkers:")
    println(io, "  ", length(mrw.initialstate))
    println(io, " Initial state:")
    println(io, "  ", mrw.initialstate)
    println(io, "")
    println(io, " MultiSampler that allows i.i.d. steps to be drawn:")
    println(io, "  ", mrw.stepsampler)
    return nothing
end

"""
    Base.eltype(mrw::MultiRandomWalk) -> DataType

Return the type associated with `mrw`'s domain.
"""
function Base.eltype(mrw::MultiRandomWalk)
    return typeof(mrw.initialstate[1])
end

"""
    MultiRandomWalk(nwalkers::Integer, latticedim::Integer = 1,
                    initialstate::AbstractVector{<:AbstractVector{<:Integer}} = (
                                                  repeat(zeros(Int, latticedim), nwalkers)),
                    stepsampler::MultiSampler = MultiSampler(
                            repeat([EVecSampler(latticedim)], nwalkers))) -> MultiRandomWalk

Construct and return a `MultiRandomWalk` on the integer lattice with dimension `latticedim`.

##### Complexity
- Time complexity: `O(1)`.
"""
function MultiRandomWalk(nwalkers::Integer, latticedim::Integer = 1,
                         initialstate::AbstractVector = (
                                              [zeros(Int, latticedim) for _ in 1:nwalkers]),
                         stepsampler::MultiSampler = MultiSampler(
                                               repeat([EVecSampler(latticedim)], nwalkers)))
    # check arguments
    latticedim < 1 && throw(ArgumentError("latticedim must be positive."))
    nwalkers < 1 && throw(ArgumentError("nwalkers must be positive."))
    for i in 1:length(initialstate)
        length(initialstate[i]) != latticedim &&
            throw(DimensionMismatch("initialstate's elements' lengths should equal
                                    latticedim"))
    end

    if latticedim == 1
        return MultiRandomWalk(Int, initialstate, stepsampler)
    else
        return MultiRandomWalk(repeat([Int], latticedim), initialstate, stepsampler)
    end
end

"""
    MultiRandomWalk(graph::AbstractGraph, nwalkers::Integer,
                    initialvertex::AbstractVector = repeat([rand(1:nv(graph))], nwalkers);
                    checkargs::Bool = true) -> MultiRandomWalk

Construct and return a `MultiRandomWalk` on a graph.

##### Complexity
- Time complexity: `O(n)` when `checkargs == true`; otherwise, `O(1)`.
"""
function MultiRandomWalk(graph::AbstractGraph, nwalkers::Integer,
                        initialvertex::AbstractVector=repeat([rand(1:nv(graph))], nwalkers);
                        checkargs::Bool = true)

    if checkargs && !(initialvertex in vertices(graph))
        throw(ArgumentError("initialvertex must be a vertex in graph)."))
    else
        return RandomWalk(graph, initialvertex, NeighborSampler(graph, initialvertex))
    end
end

"""
    nwalkers(mrw::MultiRandomWalk) -> Int

Return the number of walkers in `mrw`.

##### Complexity
- Time complexity: `O(1)`.
"""
function nwalkers(mrw::MultiRandomWalk)
    return length(initialstate)
end
