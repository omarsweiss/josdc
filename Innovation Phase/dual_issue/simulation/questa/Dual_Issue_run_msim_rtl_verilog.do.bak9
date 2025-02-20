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

vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/testbench.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/mux2x1.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/Pipes.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/t_pipe.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/SignExtender.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/registerFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/programCounter.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/ForwardingUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/controlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/comparator.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/instructionMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/fetch_taken.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/decode.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/execute.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/fetch_not_taken.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/not_t_pipe.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/Dual_Issue.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/dataMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/branch_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/mux_test.v}

vlog -vlog01compat -work work +incdir+C:/Users/firas/Developement/josdc/josdc/Innovation\ Phase/dual_issue {C:/Users/firas/Developement/josdc/josdc/Innovation Phase/dual_issue/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
