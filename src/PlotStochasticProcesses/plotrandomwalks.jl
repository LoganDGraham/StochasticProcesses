"""
    plot(randomwalk::RandomWalk{<:DataType, <:Real, <:Sampleable},
         ntimesteps::Integer = 1000, nrealizations::Integer = 20) -> nothing

Simulate and plot `numrealiaztions` realizations of a one-dimensional `RandomWalk`.
"""
function plot(randomwalk::RandomWalk{<:DataType, <:Real, <:Sampleable},
              ntimesteps::Integer = 1000, nrealizations::Integer = 20)
    mytitle = string(nrealizations, " realizations of a random walk")

    if nrealizations == 1
        mylw, myalpha, mytitle = 3, 0.9, string("1 realization of a random walk")
    elseif nrealizations <= 3
        mylw, myalpha = 3, 0.9
    elseif nrealizations <= 10
        mylw, myalpha = 3, 0.6
    elseif nrealizations <= 20
        mylw, myalpha = 2, 0.5
    else
        mylw, myalpha = 1, 0.5
    end
    myplot = Plots.plot(rand(randomwalk, ntimesteps), title=mytitle, lw=mylw, alpha=myalpha,
                        xlabel="Time", leg=false)

    # display and return if only one realization is to be drawn
    if nrealizations == 1
        display(myplot)
        return nothing
    end
    # mutate myplot with additional realizations
    for step in 2:nrealizations
        plot!(myplot, rand(randomwalk, ntimesteps), lw=mylw, alpha=myalpha, leg=false)
    end
    display(myplot)
    return nothing
end

"""
    plot(randomwalk::RandomWalk{<:AbstractGraph, <:Integer, <:Sampleable},
         ntimesteps::Integer = 30) -> nothing

Simulate and plot one realization of a random walk on a graph by using animation.
"""
function plot(randomwalk::RandomWalk{<:AbstractGraph, <:Integer, <:Sampleable},
              ntimesteps::Integer = 30, filename::AbstractString = "myanimation.gif";
              method = :circular)
    # simulate the random walk, and store the realization
    realizationvec = rand(randomwalk, ntimesteps)
    nodecolors = [:grey, :red]
    nodenames = string.(collect(vertices(randomwalk.statespace)),
                        pad=length(string(ntimesteps)))
    anim = @animate for step in 1:ntimesteps
        colorindices = ones(Int, nv(randomwalk.statespace))
        colorindices[realizationvec[step]] = 2
        mynodefillc = nodecolors[colorindices]
        graphplot(randomwalk.statespace, nodecolor=mynodefillc, nodeshape=:circle,
                  nodesize=0.2, names=nodenames, curves=false, method=method)
    end
    return gif(anim, filename, fps=1)
end
