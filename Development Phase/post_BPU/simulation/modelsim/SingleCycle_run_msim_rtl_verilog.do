transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/instructionMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/testbench.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/registerFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/controlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/signextender.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/programCounter.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/mux2x1.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/dataMemory.v}

vlog -vlog01compat -work work +incdir+C:/Users/GIGABYT/Desktop/puter/Development\ Phase\ II,\ JoSDC/SDC24_QP_SingleCycle_baseline {C:/Users/GIGABYT/Desktop/puter/Development Phase II, JoSDC/SDC24_QP_SingleCycle_baseline/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
