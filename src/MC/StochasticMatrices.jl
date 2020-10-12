"""
We define the `StochasticMatrix` type and associated functionality herein. This module was
written as an exercise in interfacing with and extending the Base library. If one intends to
work with stochastic matrices in practice, the more idiomatic approach is to work with
matrices, but perform checks with the `isstochastic` function. Why does this make sense?
Core operations such as matrix multiplication, getindex, setindex!, show, etc. work the same
on matrices as they do on stochastic matrices. One would need to (trivially) extend all such
functions to operate on stochastic matrices. This is wasteful and more trouble than it is
worth. Note that it DOES make sense to implement e.g. `Diagonal` matrices seperately from
general matrices, for operations such as matrix multiplication can be much more efficient on
the former than on the latter.
"""
module StochasticMatrices
export StochasticMatrix


"""
    StochasticMatrix{T, S<:AbstractMatrix{T} <: AbstractMatrix{T}

A square `Matrix` whose elements are all between `0` and `1` and whose rows all sum to `1`.

Our inner constructor calls `isstochastic` for safety.

##### Fields
- `matrix::S` : the stochastic matrix.

##### Complexity (for default constructor)
- Time complexity: `O(n^2)`, where `n` denotes the number of rows (or columns) in a square
matrix.
"""
struct StochasticMatrix{T, S<:AbstractMatrix{T}} <: AbstractMatrix{T}
    matrix::S
    function StochasticMatrix{T, S}(matrix) where {T, S<:AbstractMatrix{T}}
        if !isstochastic(matrix)
            error("Oh no! The matrix that you passed is not stochastic.")
        end
        return new{T, S}(matrix)
    end
end

"""
    StochasticMatrix(matrix::AbstractMatrix{T}) where {T} -> StochasticMatrix

Construct a `StochasticMatrix`.
"""
function StochasticMatrix(matrix::AbstractMatrix{T}) where {T}
    return StochasticMatrix{T, typeof(matrix)}(matrix)
end

"""
    Base.show(io::IO, stochasticmatrix::StochasticMatrix)

Show a `StochasticMatrix` in a human-friendly manner.
"""
function Base.show(io::IO, stochasticmatrix::StochasticMatrix)
    println(typeof(stochasticmatrix), ":")
    println(stochasticmatrix.matrix)
end

"""
    Base.size(stochasticmatrix::StochasticMatrix) -> Tuple{Int, Int}

Return a 2-tuple `(nrows, ncolumns)`.
"""
function Base.size(stochasticmatrix::StochasticMatrix)
    return size(stochasticmatrix.matrix)
end

"""
    Base.getindex(stochasticmatrix::StochasticMatrix)
"""
function Base.getindex(stochasticmatrix::StochasticMatrix, i::Integer, j::Integer)
    return Base.getindex(stochasticmatrix.matrix, i, j)
end

"""
    Base.setindex!(stochasticmatrix::StochasticMatrix, i::Integer, j::Integer) -> nothing
"""
function Base.setindex!(stochasticmatrix::StochasticMatrix, i::Integer, j::Integer)
    Base.setindex!(stochasicmatrix.matrix, i, j)
    return nothing
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
    # if non-square
    if size(matrix)[1] != size(matrix)[2]
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
end
