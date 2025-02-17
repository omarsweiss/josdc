onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/out1
add wave -noupdate /testbench/out2
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/out1
add wave -noupdate /testbench/out2
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/out1
add wave -noupdate /testbench/out2
add wave -noupdate -radix decimal -childformat {{{/testbench/uut/u_t_pipe/u_decode/rf/registers[0]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[1]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[2]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[3]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[4]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[5]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[6]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[7]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[8]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[9]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[10]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[11]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[12]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[13]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[14]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[15]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[16]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[17]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[18]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[19]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[20]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[21]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[22]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[23]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[24]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[25]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[26]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[27]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[28]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[29]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[30]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[31]} -radix decimal}} -expand -subitemconfig {{/testbench/uut/u_t_pipe/u_decode/rf/registers[0]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[1]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[2]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[3]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[4]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[5]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[6]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[7]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[8]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[9]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[10]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[11]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[12]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[13]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[14]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[15]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[16]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[17]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[18]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[19]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[20]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[21]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[22]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[23]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[24]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[25]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[26]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[27]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[28]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[29]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[30]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[31]} {-height 15 -radix decimal}} /testbench/uut/u_t_pipe/u_decode/rf/registers
add wave -noupdate -divider {branch control}
add wave -noupdate /testbench/uut/u_t_pipe/u_decode/rf/we2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/writeData2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/writeRegister2
add wave -noupdate /testbench/uut/u_branch_control/pipe_valid
add wave -noupdate /testbench/uut/u_branch_control/taken1_n
add wave -noupdate /testbench/uut/u_branch_control/taken1_t
add wave -noupdate /testbench/uut/u_branch_control/taken2_n
add wave -noupdate /testbench/uut/u_branch_control/taken2_t
add wave -noupdate /testbench/uut/u_branch_control/Branch1_n
add wave -noupdate /testbench/uut/u_branch_control/Branch1_t
add wave -noupdate /testbench/uut/u_branch_control/Branch2_n
add wave -noupdate /testbench/uut/u_branch_control/Branch2_t
add wave -noupdate -divider PCs
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/return_addr2_EX
add wave -noupdate -divider comparator
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp1/branch
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp1/branchValid
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp1/In1
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp1/In2
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp2/branch
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp2/branchValid
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp2/In1
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/comp2/In2
add wave -noupdate -divider alu
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/aluRes1
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/aluRes2
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/readData1_1
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/readData1_2
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/readData2_1
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/readData2_2
add wave -noupdate -divider {forwarding cond}
add wave -noupdate /testbench/uut/u_t_pipe/u_decode/CU2/RegWriteEn
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/rs2_ID
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/rt2_ID
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/dest1_EX
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/dest2_EX
add wave -noupdate /testbench/uut/u_forwarding_unit_t/rt2_eq_d1ex
add wave -noupdate /testbench/uut/u_forwarding_unit_t/regwrite1_EX
add wave -noupdate /testbench/uut/u_forwarding_unit_t/regwrite2_EX
add wave -noupdate /testbench/uut/u_forwarding_unit_t/d1ex_valid
add wave -noupdate -divider forwarding
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/readData1_1
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/readData1_2
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/readData2_1
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/readData2_2
add wave -noupdate /testbench/uut/u_t_pipe/u_decode/ForwardA1
add wave -noupdate /testbench/uut/u_t_pipe/u_decode/ForwardA2
add wave -noupdate /testbench/uut/u_t_pipe/u_decode/ForwardB1
add wave -noupdate /testbench/uut/u_t_pipe/u_decode/ForwardB2
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/aluRes1_EX
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/aluRes1_MEM
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/aluRes2_EX
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_decode/aluRes2_MEM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {206682 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 367
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 5000
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {160923 ps} {235695 ps}
