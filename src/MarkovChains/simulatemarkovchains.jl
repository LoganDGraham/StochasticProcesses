"""
    Base.rand(markovchain::MarkovChain, ntimesteps::Integer) -> Vector{Int}

Simulate `markovchain` for `ntimesteps` time-steps, returning one sample path (i.e.
trajectory) of length `ntimesteps`.

The time steps represented in the sample path are `0, 1, ..., ntimesteps-1`, for we start
with an initial state.

##### Complexity
- Time complexity: `O(n)`.
"""
function Base.rand(markovchain::MarkovChain, ntimesteps::Integer)
    rowmarginals = Vector{Categorical}(undef, length(markovchain.initialdist))
    for (index, row) in enumerate(eachrow(markovchain.transitionmatrix))
        rowmarginals[index] = Categorical(row[:,1])
    end

    # allocate memory
    realizationvec = Vector{Int}(undef, ntimesteps)
    realizationvec[1] = rand(Categorical(markovchain.initialdist))
    for step in 2:ntimesteps
        # sample from the distribution associated with the previous state's row
        realizationvec[step] = rand(rowmarginals[realizationvec[step-1]])
    end
    return realizationvec
end
