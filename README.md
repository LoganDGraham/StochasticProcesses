# StochasticProcesses

[![Build Status](https://travis-ci.com/LoganDGraham/StochasticProcesses.jl.svg?branch=master)](https://travis-ci.com/LoganDGraham/StochasticProcesses.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/LoganDGraham/StochasticProcesses.jl?svg=true)](https://ci.appveyor.com/project/LoganDGraham/StochasticProcesses-jl)

A lightweight, efficient package for simulating stochastic processes on various domains.

## Installation
Installation is straightforward: enter Pkg mode by hitting `]`, and then run
```julia-repl
(v1.0) pkg> add StochasticProcesses
```

## Basic Example
Bring `StochasticProcesses`'s exported items into the namespace by running
```julia-repl
using StochasticProcesses
```

Instantiate a one-dimensional random walk:
```julia-repl
rw = RandomWalk(1)
```

Simulate 20 realizations of the random walk `rw` and plot the results:
```julia-repl
plot(rw)
```

A pop-up window should render something like the following:

<img src='/images/rw_example.png' width='800' height='500'>
