"""
    PoissonProcess{T<:Real} <: AbstractMarkovChain

##### Fields
- `rate::T` : the rate; i.e., the parameter "lambda".
"""
struct PoissonProcess{T<:Real} <: AbstractMarkovChain
    rate::T
end

"""
    Base.show(io::IO, pp::PoissonProcess) -> nothing

Show a `PoissonProcess` in a human-friendly manner.
"""
function Base.show(io::IO, pp::PoissonProcess)
    println(io, typeof(pp))
    println(io, " Rate (i.e. lambda):")
    println(io, pp.rate)
    return nothing
end

"""
    Base.eltype(pp::PoissonProcess) -> DataType

Return the type associated with `pp`'s `rate` parameter.
"""
function Base.eltype(pp::PoissonProcess)
    return typeof(pp.rate)
end

"""
    nexpectedarrivals(pp::PoissonProcess, intervallength::Real) -> Int

Return the expected number of arrivals `E[N(intervallength)]` over the time interval
`[0, intervallength]` for `pp`.

##### Complexity
-Time complexity: `O(1)`.
"""
function nexpectedarrivals(pp::PoissonProcess, intervallength::Real)
    return pp.rate*intervallength
end
