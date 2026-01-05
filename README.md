This repository contains the code accompanying the paper:
**"Stronger Cuts for Benders’ Decomposition for Stochastic Unit Commitment Problems Based on Interval Variables."**

## Repository Structure

* **`Data/`**
  Contains input data files used in the experiments:

  * `T-Ramp/`: SMS++ instance files
  * `IEEE/`: IEEE 118-bus test case
  * `Uncertainty/`: Data used to generate uncertainty scenarios for the SMS++ instances

* **`Src/`**
  Julia source files implementing various solution approaches:

  * Extensive formulation
  * Benders' Decomposition with enhanced cuts

* **`test.jl`**
  A simple example script demonstrating how to run the code:

  1. Open a Julia REPL
  2. Run `include("test.jl")`
  3. Call `test(time_limit=30, size=10, S=25)` to reproduce the second line of Table 1.

     * In the paper, the `time_limit` was set to 3600s, but for testing you may reduce it to 30s.
     * The `size` parameter defines the number of units. (You can choose 10, 50 or 100).
     * `S` is the number of scenarios.

> Note: The 3-bin Benders’ Decomposition and Extended BD-O approaches have been removed by default. You can re-enable it by uncommenting the corresponding lines in `test.jl`.
