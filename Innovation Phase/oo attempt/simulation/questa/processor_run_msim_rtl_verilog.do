transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/intelfpga/23.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/intelfpga/23.1std/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/intelfpga/23.1std/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/intelfpga/23.1std/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/intelfpga/23.1std/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/fiftyfivenm_ver
vmap fiftyfivenm_ver ./verilog_libs/fiftyfivenm_ver
vlog -vlog01compat -work fiftyfivenm_ver {c:/intelfpga/23.1std/quartus/eda/sim_lib/fiftyfivenm_atoms.v}
vlog -vlog01compat -work fiftyfivenm_ver {c:/intelfpga/23.1std/quartus/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/testbench.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/mux2x1.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/SignExtender.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/registerFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/controlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/instructionMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/programCounter.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/ROB.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/RAT.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/reservation_station.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/InstructionQueue.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/oo\ attempt {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/oo attempt/processor.v}

