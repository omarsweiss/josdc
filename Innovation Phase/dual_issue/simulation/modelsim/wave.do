onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/out1
add wave -noupdate /testbench/out2
add wave -noupdate /testbench/out1
add wave -noupdate /testbench/out2
add wave -noupdate -radix decimal -childformat {{{/testbench/uut/u_t_pipe/u_decode/rf/registers[0]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[1]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[2]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[3]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[4]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[5]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[6]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[7]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[8]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[9]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[10]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[11]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[12]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[13]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[14]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[15]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[16]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[17]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[18]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[19]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[20]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[21]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[22]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[23]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[24]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[25]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[26]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[27]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[28]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[29]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[30]} -radix decimal} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[31]} -radix decimal}} -expand -subitemconfig {{/testbench/uut/u_t_pipe/u_decode/rf/registers[0]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[1]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[2]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[3]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[4]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[5]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[6]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[7]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[8]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[9]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[10]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[11]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[12]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[13]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[14]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[15]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[16]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[17]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[18]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[19]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[20]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[21]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[22]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[23]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[24]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[25]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[26]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[27]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[28]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[29]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[30]} {-height 15 -radix decimal} {/testbench/uut/u_t_pipe/u_decode/rf/registers[31]} {-height 15 -radix decimal}} /testbench/uut/u_t_pipe/u_decode/rf/registers
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/clk
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/rst
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/we1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/we2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rs1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rs2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rst
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rt1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rt2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readRegister1_1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readRegister2_1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readRegister1_2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readRegister2_2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/writeRegister1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/writeRegister2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/writeData1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/writeData2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readData1_1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readData2_1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readData1_2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_decode/rf/readData2_2
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/alu1/result
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/u_execute/alu2/result
add wave -noupdate /testbench/uut/u_t_pipe/u_execute/ForwardA_1
add wave -noupdate /testbench/uut/u_t_pipe/u_execute/ForwardB_1
add wave -noupdate /testbench/uut/u_t_pipe/u_execute/ForwardA_2
add wave -noupdate /testbench/uut/u_t_pipe/u_execute/ForwardB_2
add wave -noupdate -radix decimal /testbench/uut/DM/address_a
add wave -noupdate -radix decimal /testbench/uut/DM/address_b
add wave -noupdate -radix decimal /testbench/uut/DM/data_a
add wave -noupdate -radix decimal /testbench/uut/DM/data_b
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/return_addr1_MEM
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/return_addr1_MEM
add wave -noupdate /testbench/uut/taken_pipe
add wave -noupdate -radix decimal /testbench/uut/DM/wren_a
add wave -noupdate -radix decimal /testbench/uut/DM/wren_b
add wave -noupdate -radix decimal /testbench/uut/u_not_t_pipe/return_addr1_EX
add wave -noupdate -radix decimal /testbench/uut/u_t_pipe/return_addr1_EX
add wave -noupdate /testbench/uut/taken1_n
add wave -noupdate /testbench/uut/taken2_n
add wave -noupdate /testbench/uut/taken1_t
add wave -noupdate /testbench/uut/taken2_t
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/rs1
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/rs2
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/rt1
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/rt2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_execute/comp2/branch
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_execute/comp2/branchValid
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_execute/comp2/In1
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_execute/comp2/In2
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/u_execute/comp2/branch
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/u_execute/comp2/branchValid
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/u_execute/comp2/In1
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/u_execute/comp2/In2
add wave -noupdate /testbench/uut/u_forwarding_unit_t/ForwardA2
add wave -noupdate /testbench/uut/u_forwarding_unit_t/ForwardB2
add wave -noupdate /testbench/uut/u_forwarding_unit_n/ForwardA2
add wave -noupdate /testbench/uut/u_forwarding_unit_n/ForwardB2
add wave -noupdate -radix decimal /testbench/uut/u_not_t_pipe/u_execute/aluRes1_WB
add wave -noupdate -radix unsigned /testbench/uut/WritePc1/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {421467 ps} 0}
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
WaveRestoreZoom {388604 ps} {464478 ps}
