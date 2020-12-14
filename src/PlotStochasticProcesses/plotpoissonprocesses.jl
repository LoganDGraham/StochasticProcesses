"""
    getplotvectors(pp::PoissonProcess, intervallength::Real) -> (Tuple{Vector{Float64},
                                                                 Vector{Int}})

Simulate `pp` over the interval `[0, intervallength]`, and return the vectors needed to
plot.

We duplicate vector entries in the returned tuple in order to help us plot an orthogonal
polygonal chain.
"""
function getplotvectors(pp::PoissonProcess, intervallength::Real)
    # simulate
    arrivaltimes = rand(pp, intervallength)
    if length(arrivaltimes) == 0
        return Float64[], Int[]
    end
    # allocate memory
    paddedarrivals = Vector{Float64}(undef, 2*length(arrivaltimes))
    paddednarrivals = Vector{Int}(undef, 2*length(arrivaltimes))
    # duplicate vector entries for plotting purposes (we want an orthogonal polygonal chain)
    for (i, value) in enumerate(arrivaltimes)
        paddedarrivals[2*i-1], paddedarrivals[2*i] = value, value
    end
    # pattern: 0, 1, 1, 2, 2, ..., length(arrivaltimes)
    paddednarrivals[1] = 0
    for i in 1:(length(arrivaltimes)-1)
        paddednarrivals[2*i], paddednarrivals[2*i+1] = i, i
    end
    paddednarrivals[length(paddednarrivals)] = length(arrivaltimes)
    return paddedarrivals, paddednarrivals
end

"""
    plot(pp::PoissonProcess, intervallength::Real = 30.0, nrealizations::Integer = 10) -> (
    nothing)

Simulate and plot `nrealizations` realizations of a `PoissonProcess`.
"""
function plot(pp::PoissonProcess, intervallength::Real = 30.0, nrealizations::Integer = 10)
    mytitle = string(nrealizations, " realizations of a Poisson process with arrival rate ",
                     pp.rate)

    if nrealizations == 1
        mylw, myalpha, mytitle = 3, 0.9, string("1 realization of a Poisson process with ",
                                                "arrival rate ", pp.rate)
    elseif nrealizations <= 3
        mylw, myalpha = 3, 0.9
    elseif nrealizations <= 10
        mylw, myalpha = 3, 0.6
    elseif nrealizations <= 20
        mylw, myalpha = 2, 0.5
    else
        mylw, myalpha = 1, 0.5
    end

    xs, ys = getplotvectors(pp, intervallength)
    myplot = Plots.plot(xs, ys, title=mytitle, lw=mylw, alpha=myalpha, xlabel="Time",
                        leg=false)

    # display and return if only one realization is to be drawn
    if nrealizations == 1
        display(myplot)
        return nothing
    end
    # mutate myplot with additional realizations
    for step in 2:nrealizations
        xs, ys = getplotvectors(pp, intervallength)
        Plots.plot!(myplot, xs, ys, lw=mylw, alpha=myalpha, leg=false)
    end
    display(myplot)
    return nothing
end
