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
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/out1
add wave -noupdate /testbench/out2
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_fetch_taken/PC
add wave -noupdate -radix unsigned /testbench/uut/u_not_t_pipe/u_fetch_not_taken/PC
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_fetch_taken/nextPC_out
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_fetch_taken/nextPC
add wave -noupdate -radix unsigned /testbench/uut/u_t_pipe/u_fetch_taken/pc_plus
add wave -noupdate -radix unsigned -childformat {{{/testbench/uut/u_t_pipe/u_decode/rf/registers[0]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[1]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[2]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[3]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[4]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[5]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[6]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[7]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[8]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[9]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[10]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[11]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[12]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[13]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[14]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[15]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[16]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[17]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[18]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[19]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[20]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[21]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[22]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[23]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[24]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[25]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[26]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[27]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[28]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[29]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[30]} -radix unsigned} {{/testbench/uut/u_t_pipe/u_decode/rf/registers[31]} -radix unsigned}} -expand -subitemconfig {{/testbench/uut/u_t_pipe/u_decode/rf/registers[0]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[1]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[2]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[3]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[4]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[5]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[6]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[7]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[8]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[9]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[10]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[11]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[12]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[13]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[14]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[15]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[16]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[17]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[18]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[19]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[20]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[21]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[22]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[23]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[24]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[25]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[26]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[27]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[28]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[29]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[30]} {-height 15 -radix unsigned} {/testbench/uut/u_t_pipe/u_decode/rf/registers[31]} {-height 15 -radix unsigned}} /testbench/uut/u_t_pipe/u_decode/rf/registers
add wave -noupdate -radix unsigned /testbench/uut/DestReg1_MEM
add wave -noupdate -radix unsigned /testbench/uut/DestReg2_MEM
add wave -noupdate -radix unsigned /testbench/uut/rt2_EX_n
add wave -noupdate -radix unsigned /testbench/uut/rt1_EX_n
add wave -noupdate -radix unsigned /testbench/uut/rt2_EX_t
add wave -noupdate -radix unsigned /testbench/uut/rt1_EX_t
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/rt1_mem
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/rt2_mem
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/dest1_wb
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/dest2_wb
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/dest1_wb
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/dest2_wb
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/rt1_mem
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/rt2_mem
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/MemWriteEn1_MEM
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/MemWriteEn2_MEM
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/MemWriteEn1_MEM
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_t/MemWriteEn2_MEM
add wave -noupdate -radix unsigned /testbench/uut/MemWriteEn1_EX_t
add wave -noupdate -radix unsigned /testbench/uut/MemWriteEn2_EX_t
add wave -noupdate -radix unsigned /testbench/uut/MemWriteEn1_EX_n
add wave -noupdate -radix unsigned /testbench/uut/MemWriteEn2_EX_n
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/memFw1
add wave -noupdate -radix unsigned /testbench/uut/u_forwarding_unit_n/memFw2
add wave -noupdate -radix unsigned /testbench/uut/memFw1
add wave -noupdate -radix unsigned /testbench/uut/memFw2
add wave -noupdate -radix unsigned /testbench/uut/memFw1_n
add wave -noupdate -radix unsigned /testbench/uut/memFw2_n
add wave -noupdate -radix unsigned /testbench/uut/memFw1_t
add wave -noupdate -radix unsigned /testbench/uut/memFw2_t
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {180000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 324
configure wave -valuecolwidth 117
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {152359 ps} {341151 ps}
