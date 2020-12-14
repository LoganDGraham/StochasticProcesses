# StochasticProcesses

A lightweight, efficient package for simulating stochastic processes on various domains.

## Installation
Installation is straightforward: enter Pkg mode by hitting `]`, and then run
```julia-repl
(v1.5) pkg> add StochasticProcesses
```

## Basic Examples
Bring `StochasticProcesses`'s exported items into the namespace by running
```julia-repl
using StochasticProcesses
```

### Random Walk
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

### Poisson Process
Instantiate a homogeneous Poisson process with arrival rate `1.0`:
```julia-repl
pp = PoissonProcess(1.0)
```

Simulate 10 realizations of the Poisson process `pp` over the time interval `[0, 30]`, and
plot the results:
```julia-repl
plot(pp)
```

A pop-up window should render something like the following:

<img src='/images/poisson_process_example.png' width='800' height='500'>
