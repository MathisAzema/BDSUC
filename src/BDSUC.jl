module BDSUC

using JuMP
using Gurobi
using Statistics
using NCDatasets
using Plots
using XLSX
using CSV
using DataFrames

const SHEDDING_COST=700.0
const CURTAILEMENT_COST=700.0

include("Struct/Instance.jl")
include("Struct/tools.jl")
include("Unit/Thermal_unit.jl")
include("Unit/Line.jl")
include("Struct/parsing.jl")
include("Optimizer/extensive_formulation.jl")
include("Optimizer/initialisation_Benders.jl")
include("Optimizer/second_stage_SP.jl")
include("Optimizer/add_cut_SP.jl")
include("Optimizer/add_cut_AVAR.jl")
include("Optimizer/benders.jl")
include("Optimizer/benders_AVAR.jl")
include("Optimizer/options.jl")

end