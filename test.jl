using BDSUC, JuMP, Gurobi
const GRB_ENV = Gurobi.Env()
optimizer=() -> Gurobi.Optimizer(GRB_ENV)

function test(;time_limit=1,size=10, S=1)
    Num_batch=3
    Num_tests=Num_batch*5
    Extended_BD_H_time = zeros(Num_tests)
    Extended_BD_H_count = zeros(Int,Num_tests)
    Extended_BD_O_time = zeros(Num_tests)
    Extended_BD_O_count = zeros(Int,Num_tests)
    bin_extensive_time = zeros(Num_tests)
    bin_extensive_count = zeros(Int,Num_tests)
    extended_extensive_time = zeros(Num_tests)
    extended_extensive_count = zeros(Int,Num_tests)
    BD3bin_time = zeros(Num_tests)
    BD3bin_count = zeros(Int,Num_tests)
    for N in 1:5
        name="Data/T-Ramp/"*"$size"*"_0_"*"$N"*"_w.nc4"
        instance=BDSUC.parse_nc4(name,  optimizer, 24) #read the data
        for batch in 1:Num_batch
            res_extended_BD_H=BDSUC.benders_callback(instance, BDSUC.extended_BD_FH_OH, silent=true, force=1.0, S=S, batch=batch, gap=0.1, timelimit=time_limit);
            if res_extended_BD_H !== nothing && res_extended_BD_H[2] <= time_limit-1
                Extended_BD_H_time[(N-1)*Num_batch + batch] = res_extended_BD_H[2]
                Extended_BD_H_count[(N-1)*Num_batch + batch] = 1
            else
                Extended_BD_H_count[(N-1)*Num_batch + batch] = 0
            end
            # res_extended_BD_O=BDSUC.benders_callback(instance, BDSUC.extended_BD_FH_OE, silent=true, force=1.0, S=S, batch=batch, gap=0.1, timelimit=time_limit);
            # if res_extended_BD_O !== nothing && res_extended_BD_O[2] <= time_limit-1
            #     Extended_BD_O_time[(N-1)*Num_batch + batch] = res_extended_BD_O[2]
            #     Extended_BD_O_count[(N-1)*Num_batch + batch] = 1
            # else
            #     Extended_BD_O_count[(N-1)*Num_batch + batch] = 0
            # end
            res_bin_extensive=BDSUC.bin_extensive_neutral(instance, silent=true, force=1.0, S=S, batch=batch, gap=0.1/100, timelimit=time_limit);
            if res_bin_extensive !== nothing && res_bin_extensive[2] <= time_limit-1
                bin_extensive_time[(N-1)*Num_batch + batch] = res_bin_extensive[2]
                bin_extensive_count[(N-1)*Num_batch + batch] = 1
            else
                bin_extensive_count[(N-1)*Num_batch + batch] = 0
            end
            res_extended_extensive=BDSUC.extended_extensive_neutral(instance, silent=true, force=1.0, S=S, batch=batch, gap=0.1/100, timelimit=time_limit);
            if res_extended_extensive !== nothing && res_extended_extensive[2] <= time_limit-1
                extended_extensive_time[(N-1)*Num_batch + batch] = res_extended_extensive[2]
                extended_extensive_count[(N-1)*Num_batch + batch] = 1
            else
                extended_extensive_count[(N-1)*Num_batch + batch] = 0
            end

            # res_BD3bin=BDSUC.benders3bin_callback(instance, BDSUC.binBD, silent=true, force=1.0, S=S, batch=batch, gap=0.1, timelimit=time_limit);
            # if res_BD3bin !== nothing && res_BD3bin[2] <= time_limit-1
            #     BD3bin_time[batch] = res_BD3bin[2]
            #     BD3bin_count[batch] = 1
            # else
            #     BD3bin_count[batch] = 0
            # end
        end
    end

    println("Extended_BD_H: ", sum(Extended_BD_H_time)/sum(Extended_BD_H_count), " (", sum(Extended_BD_H_count), "/$Num_tests)")
    # println("Extended_BD_O: ", sum(Extended_BD_O_time)/sum(Extended_BD_O_count), " (", sum(Extended_BD_O_count), "/$Num_tests)")
    println("3bin-extensive: ", sum(bin_extensive_time)/sum(bin_extensive_count), " (", sum(bin_extensive_count), "/$Num_tests)")
    println("Extended-extensive: ", sum(extended_extensive_time)/sum(extended_extensive_count), " (", sum(extended_extensive_count), "/$Num_tests)")
    # println("3bin_BD: ", sum(BD3bin_time)/sum(BD3bin_count), " (", sum(BD3bin_count), "/$Num_tests)")

end