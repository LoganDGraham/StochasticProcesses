"""
    PoissonProcess{T<:Real} <: AbstractStochasticProcess

##### Fields
- `rate::T` : the rate; i.e., the parameter "lambda".
"""
struct PoissonProcess{T<:Real} <: AbstractStochasticProcess
    rate::T
end

"""
    Base.show(io::IO, pp::PoissonProcess)

Show a `PoissonProcess` in a human-friendly manner.
"""
function Base.show(io::IO, randomwalk::RandomWalk)
    println(io, typeof(randomwalk))
    println(io, " State Space:")
    println(io, "  ", randomwalk.statespace)
    println(io, " Initial state:")
    println(io, "  ", randomwalk.initialstate)
    println(io, " Sampler that allows i.i.d. steps to be drawn:")
    println(io, "  ", randomwalk.stepsampler)
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
