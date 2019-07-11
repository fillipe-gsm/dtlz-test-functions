# dtlz-test-functions

This is an Octave/Matlab* (see note below) toolbox that implements the DTLZ
multi-objective scalable test problems [1]. If you work with Multi-objective
Evolutionary Algorithms (such as NGSA-II, SPEA-2, DEMO etc.) and wishes to test
your algorithm with an arbitrary number of objectives, chances are that
this toolbox will be useful for you.

Currently this repository implements:

- DTLZ functions from DTLZ1 to DTLZ7 with any number of objectives M &ge; 2;
- A code to measure the distance from a given solution x to the Pareto-optimal
set of a DTLZ function (this approach is better explained in [2], chapter 6);
- A code to compute the ideal and Nadir solutions of these functions (if the
Nadir computation of the DTLZ7 seems too arbitrary, check the small documentation
in the `docs` folder explaining its derivation).

## Requirements:
- Octave &ge; 4.0;

# How to run the code
To use these functions, download the folder `Octave-Matlab` and put it into your
path. Each `m` file has a helper showing how to use the code, so, in doubt,
type `help filename` in the console and check the examples or simply read the
code.

# Regarding Matlab
The code was developed and tested in Octave. In my opinion, besides being free,
it is now more than capable of replacing Matlab, which is just too expensive for
use outside a large company (and even in this case I can argue that Octave
is also enough). Even so, I tried to make the code compatible with both softwares.
However, since I have no Matlab copy to check, if it does break, I would be
honored to receive a bug or a (even better) pull request helping to solve it.

# References
1. Kalyanmoy Deb, Lothar Thiele, Marco Laumanns, and Eckart Zitzler. Scalable test problems
for evolutionary multiobjective optimization. Technical Report 1990, 2005.
2. Fillipe Goulart. Preference-guided Evolutionary Algorithms for Optimization with Many Objectives. Master’s thesis, Universidade Federal de Minas Gerais, 2014.
