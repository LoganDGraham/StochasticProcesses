abstract type AbstractStochasticProcess end
abstract type AbstractMarkovChain <: AbstractStochasticProcess end


"""
    MarkovChain

A discrete-time, discrete-space, finite-space Markov chain.

##### Fields
- `transitionmatrix::Matrix{Float64}` : stochastic matrix in which element `[i,j]` denotes
the probability that the Markov chain transitions from state `i` to state `j`.
- `initialdist::Vector{Float64}` : stochastic vector in which element `i` denotes the
probability that the Markov chain's initial state is `i`.

##### Complexity (for the inner constructor)
- Time complexity: `O(n^2)`, where `n` denotes the number of rows (or columns) in a square
matrix.
"""
struct MarkovChain <: AbstractMarkovChain
    transitionmatrix::Matrix{Float64}
    initialdist::Vector{Float64}
    # ensure that the transition matrix and the initial distribution are stochastic
    function MarkovChain(transitionmatrix::AbstractMatrix{<:Real},
                         initialdist::AbstractVector{<:Real})
        size(transitionmatrix)[1] != length(initialdist) &&
            ArgumentError("Uh-oh! The transition matrix must have the same number of rows as
                          the initial distribution has elements.") |> throw
        !isstochastic(initialdist) || !isstochastic(transitionmatrix) &&
            ArgumentError("Oops! The transition matrix and the initial distribution must be
                          stochastic.") |> throw
        return new(transitionmatrix, initialdist)
    end
end

"""
    Base.show(io::IO, markovchain::MarkovChain) -> nothing

Show a `MarkovChain` in a human-friendly manner.
"""
function Base.show(io::IO, markovchain::MarkovChain)
    println(io, typeof(markovchain))
    println(io, " Initial distribution:")
    println(io, "  ", markovchain.initialdist)
    println(io, " Transition matrix:")
    println(io, "  ", markovchain.transitionmatrix)
    return nothing
end

"""
    MarkovChain(transitionmatrix::AbstractMatrix{<:Real},
                initialdist::AbstractMatrix{<:Real}) -> MarkovChain

Construct a `MarkovChain` when the initial distribution `initialdist` is specified as either
a one-row or a one-column matrix.

##### Complexity
- Time complexity: `O(n^2)`, where `n` denotes the number of rows (or columns) in a square
matrix.
"""
function MarkovChain(transitionmatrix::AbstractMatrix{<:Real},
                     initialdist::AbstractMatrix{<:Real})
    nrows, ncols = size(initialdist)[1], size(initialdist)[2]
    if nrows == 1
        # make initialdist a vector
        initialdist = initialdist[1,:]
    elseif ncols == 1
        # make initialdist a vector
        initialdist = initialdist[:,1]
    else
        throw(ArgumentError("The initial distribution must be a vector."))
    end
    # multiple dispatch
    return MarkovChain(transitionmatrix, initialdist)
end

"""
    isstochastic(matrix::AbstractMatrix, tol::Float64 = 1e-5) -> Bool

Decide if `matrix` is stochastic.

`tol` is the tolerance associated with the row sums. We consider the row sums to be valid if
and only if they are in the interval `[1-tol, 1+tol]`. This is important when the element
type is `Float64`, for example.

##### Complexity
- Time complexity: `O(n^2)`, where `n` denotes the number of rows (or columns) in a square
matrix.
"""
function isstochastic(matrix::AbstractMatrix, tol::Float64 = 1e-5)
    nrows, ncols = size(matrix)[1], size(matrix)[2]
    # if matrix has only one row
    if nrows == 1
        vec = matrix[1,:]::Vector
        # multiple dispatch
        return isstochastic(vec, tol)
    # if matrix has only one column
    elseif ncols == 1
        vec = matrix[:,1]::Vector
        # multiple dispatch
        return isstochastic(vec, tol)
    # if matrix is non-square
    elseif nrows != ncols
        return false
    end
    # check if elements are in [0,1]
    for element in matrix
        if element < 0 || element > 1
            return false
        end
    end
    # check row sums
    for row in eachrow(matrix)
        rowsum = sum(row)
        if rowsum < 1 - tol || rowsum > 1 + tol
            return false
        end
    end
    return true  # this line is reached only if all above checks pass
end

"""
    isstochastic(vector::AbstractVector, tol::Float64 = 1e-5) -> Bool

Decide if `vector` is stochastic.

`tol` is the tolerance associated with the sum over `vector`'s elements. We consider the sum
to be valid if and only if it is in the interval `[1-tol, 1+tol]`. This is important when
the element type is `Float64`, for example.

##### Complexity
- Time complexity: `O(n)`.
"""
function isstochastic(vector::AbstractVector, tol::Float64 = 1e-5)
    # check if elements are in [0,1]
    for element in vector
        if element < 0 || element > 1
            return false
        end
    end
    vecsum = sum(vector)
    if vecsum < 1 - tol || vecsum > 1 + tol
        return false
    end
    return true  # this line is reached only if all above checks pass
end
