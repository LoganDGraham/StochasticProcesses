"""
    Base.rand(pp::PoissonProcess, intervallength::Float64) -> Vector{Float64}

Simulate `pp` over the time interval `[0, intervallength]`, and return a vector of the
arrival times.

##### Complexity
- Time complexity: `O(E[N(t)]log(E[N(t)]))`, in expectation, where E[N(t)] denotes the
expected number of arrivals over the time interval `[0, intervallength]`.
"""
function Base.rand(pp::PoissonProcess, intervallength::AbstractFloat)
    # instantiate a Poisson random variable with distribution F1
    F1 = Poisson(nexpectedarrivals(pp, intervallength))
    # sample from F1
    narrivals = rand(F1)
    # no arrivals; return an empty Vector
    if narrivals == 0
        return []
    end

    # instantiate a Uniform random variable with distribution F2
    F2 = Uniform(0, intervallength)
    # allocate memory
    arrivaltimes = Vector{Float64}(undef, narrivals)
    for i in 1:narrivals
        arrivaltimes[i] = rand(F2)
    end
    return sort!(arrivaltimes)
end

"""
    Base.rand(pp::PoissonProcess, intervallength::Integer) -> Vector{Float64}

Allow the user to supply an integer `intervallength`, and work-around method ambiguity
arising from `Random`.
"""
function Base.rand(pp::PoissonProcess, intervallength::Integer)
    return Base.rand(pp, Float64(intervallength))
end
