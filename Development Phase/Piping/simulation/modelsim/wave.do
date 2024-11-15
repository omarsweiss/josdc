onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/uut/fetch/pc/hold
add wave -noupdate -radix decimal /testbench/PC
add wave -noupdate -radix decimal /testbench/uut/fetch/PCPlus1
add wave -noupdate -radix decimal /testbench/uut/fetch/pc/PCin
add wave -noupdate -divider -height 25 FETCH
add wave -noupdate -radix hexadecimal /testbench/uut/fetch/instruction
add wave -noupdate -radix decimal /testbench/uut/fetch/nextPC
add wave -noupdate -divider -height 25 DECODE
add wave -noupdate -radix unsigned /testbench/uut/dcd/RF/writeRegister
add wave -noupdate -radix unsigned /testbench/uut/PCPlus1_ID
add wave -noupdate -radix unsigned /testbench/uut/DestReg
add wave -noupdate -radix unsigned /testbench/uut/rs
add wave -noupdate -radix unsigned /testbench/uut/rt
add wave -noupdate -radix decimal /testbench/uut/readData1
add wave -noupdate -radix decimal /testbench/uut/readData2
add wave -noupdate -divider registers
add wave -noupdate -radix decimal /testbench/uut/dcd/RF/writeData
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[0]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[1]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[2]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[3]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[4]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[5]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[6]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[7]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[8]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[9]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[10]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[11]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[12]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[13]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[14]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[15]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[16]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[17]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[18]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[19]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[20]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[21]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[22]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[23]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[24]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[25]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[26]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[27]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[28]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[29]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[30]}
add wave -noupdate -radix decimal {/testbench/uut/dcd/RF/registers[31]}
add wave -noupdate -divider cu
add wave -noupdate /testbench/uut/dcd/CU/ALUOp
add wave -noupdate /testbench/uut/dcd/CU/ALUSrc
add wave -noupdate /testbench/uut/dcd/CU/bne
add wave -noupdate /testbench/uut/dcd/CU/Branch
add wave -noupdate /testbench/uut/dcd/CU/funct
add wave -noupdate /testbench/uut/dcd/CU/jal
add wave -noupdate /testbench/uut/dcd/CU/jr
add wave -noupdate /testbench/uut/dcd/CU/jump
add wave -noupdate /testbench/uut/dcd/CU/MemReadEn
add wave -noupdate /testbench/uut/dcd/CU/MemtoReg
add wave -noupdate /testbench/uut/dcd/CU/MemWriteEn
add wave -noupdate /testbench/uut/dcd/CU/opCode
add wave -noupdate /testbench/uut/dcd/CU/RegDst
add wave -noupdate /testbench/uut/dcd/CU/RegWriteEn
add wave -noupdate -divider -height 25 EXECUTE
add wave -noupdate -radix unsigned /testbench/uut/PCPlus1_EX
add wave -noupdate -radix decimal /testbench/uut/fw/rs_ex
add wave -noupdate -radix decimal /testbench/uut/fw/rt_ex
add wave -noupdate -radix decimal /testbench/uut/fw/dest_mem
add wave -noupdate -radix decimal /testbench/uut/fw/dest_wb
add wave -noupdate -radix decimal /testbench/uut/fw/rst
add wave -noupdate -radix decimal /testbench/uut/fw/regwrite_mem
add wave -noupdate /testbench/uut/fw/regwrite_wb
add wave -noupdate /testbench/uut/fw/ForwardA
add wave -noupdate /testbench/uut/fw/ForwardB
add wave -noupdate -radix decimal /testbench/uut/exec/alu/operand1
add wave -noupdate -radix decimal /testbench/uut/exec/alu/operand2
add wave -noupdate -radix decimal /testbench/uut/exec/alu/opSel
add wave -noupdate -radix decimal /testbench/uut/exec/alu/result
add wave -noupdate -divider HDU
add wave -noupdate /testbench/uut/HDU/forwardA_Branch
add wave -noupdate /testbench/uut/HDU/forwardB_Branch
add wave -noupdate /testbench/uut/HDU/hold
add wave -noupdate /testbench/uut/HDU/branch_has_hazard
add wave -noupdate /testbench/uut/HDU/ld_has_hazard
add wave -noupdate /testbench/uut/HDU/branch_hold
add wave -noupdate -divider {flushes uwu}
add wave -noupdate -radix hexadecimal /testbench/uut/idex/D
add wave -noupdate /testbench/uut/idex/flush
add wave -noupdate -radix hexadecimal /testbench/uut/idex/Q
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/uut/ifid/D[51]} -radix hexadecimal} {{/testbench/uut/ifid/D[50]} -radix hexadecimal} {{/testbench/uut/ifid/D[49]} -radix hexadecimal} {{/testbench/uut/ifid/D[48]} -radix hexadecimal} {{/testbench/uut/ifid/D[47]} -radix hexadecimal} {{/testbench/uut/ifid/D[46]} -radix hexadecimal} {{/testbench/uut/ifid/D[45]} -radix hexadecimal} {{/testbench/uut/ifid/D[44]} -radix hexadecimal} {{/testbench/uut/ifid/D[43]} -radix hexadecimal} {{/testbench/uut/ifid/D[42]} -radix hexadecimal} {{/testbench/uut/ifid/D[41]} -radix hexadecimal} {{/testbench/uut/ifid/D[40]} -radix hexadecimal} {{/testbench/uut/ifid/D[39]} -radix hexadecimal} {{/testbench/uut/ifid/D[38]} -radix hexadecimal} {{/testbench/uut/ifid/D[37]} -radix hexadecimal} {{/testbench/uut/ifid/D[36]} -radix hexadecimal} {{/testbench/uut/ifid/D[35]} -radix hexadecimal} {{/testbench/uut/ifid/D[34]} -radix hexadecimal} {{/testbench/uut/ifid/D[33]} -radix hexadecimal} {{/testbench/uut/ifid/D[32]} -radix hexadecimal} {{/testbench/uut/ifid/D[31]} -radix hexadecimal} {{/testbench/uut/ifid/D[30]} -radix hexadecimal} {{/testbench/uut/ifid/D[29]} -radix hexadecimal} {{/testbench/uut/ifid/D[28]} -radix hexadecimal} {{/testbench/uut/ifid/D[27]} -radix hexadecimal} {{/testbench/uut/ifid/D[26]} -radix hexadecimal} {{/testbench/uut/ifid/D[25]} -radix hexadecimal} {{/testbench/uut/ifid/D[24]} -radix hexadecimal} {{/testbench/uut/ifid/D[23]} -radix hexadecimal} {{/testbench/uut/ifid/D[22]} -radix hexadecimal} {{/testbench/uut/ifid/D[21]} -radix hexadecimal} {{/testbench/uut/ifid/D[20]} -radix hexadecimal} {{/testbench/uut/ifid/D[19]} -radix hexadecimal} {{/testbench/uut/ifid/D[18]} -radix hexadecimal} {{/testbench/uut/ifid/D[17]} -radix hexadecimal} {{/testbench/uut/ifid/D[16]} -radix hexadecimal} {{/testbench/uut/ifid/D[15]} -radix hexadecimal} {{/testbench/uut/ifid/D[14]} -radix hexadecimal} {{/testbench/uut/ifid/D[13]} -radix hexadecimal} {{/testbench/uut/ifid/D[12]} -radix hexadecimal} {{/testbench/uut/ifid/D[11]} -radix hexadecimal} {{/testbench/uut/ifid/D[10]} -radix hexadecimal} {{/testbench/uut/ifid/D[9]} -radix hexadecimal} {{/testbench/uut/ifid/D[8]} -radix hexadecimal} {{/testbench/uut/ifid/D[7]} -radix hexadecimal} {{/testbench/uut/ifid/D[6]} -radix hexadecimal} {{/testbench/uut/ifid/D[5]} -radix hexadecimal} {{/testbench/uut/ifid/D[4]} -radix hexadecimal} {{/testbench/uut/ifid/D[3]} -radix hexadecimal} {{/testbench/uut/ifid/D[2]} -radix hexadecimal} {{/testbench/uut/ifid/D[1]} -radix hexadecimal} {{/testbench/uut/ifid/D[0]} -radix hexadecimal}} -subitemconfig {{/testbench/uut/ifid/D[51]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[50]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[49]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[48]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[47]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[46]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[45]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[44]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[43]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[42]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[41]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[40]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[39]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[38]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[37]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[36]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[35]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[34]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[33]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[32]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[31]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[30]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[29]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[28]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[27]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[26]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[25]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[24]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[23]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[22]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[21]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[20]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[19]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[18]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[17]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[16]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[15]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[14]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[13]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[12]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[11]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[10]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[9]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[8]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[7]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[6]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[5]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[4]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[3]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[2]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[1]} {-height 15 -radix hexadecimal} {/testbench/uut/ifid/D[0]} {-height 15 -radix hexadecimal}} /testbench/uut/ifid/D
add wave -noupdate /testbench/uut/ifid/flush
add wave -noupdate /testbench/uut/ifid/hold
add wave -noupdate -radix hexadecimal /testbench/uut/ifid/Q
add wave -noupdate -divider comparator
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/bne
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/branch
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/branchValid
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/In1
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/In2
add wave -noupdate -divider {forward A mux}
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdAmux/in1
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdAmux/in2
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdAmux/in3
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdAmux/in4
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdAmux/out
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdAmux/s
add wave -noupdate -divider {forward B mux}
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdBmux/in1
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdBmux/in2
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdBmux/in3
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdBmux/in4
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdBmux/out
add wave -noupdate -radix decimal /testbench/uut/dcd/FrdBmux/s
add wave -noupdate -divider forwarding
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/s
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/in1
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/in2
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/in3
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/out
add wave -noupdate -radix binary /testbench/uut/exec/frwrdb/s
add wave -noupdate -radix decimal /testbench/uut/exec/frwrdb/in1
add wave -noupdate -radix decimal /testbench/uut/exec/frwrdb/in2
add wave -noupdate -radix decimal /testbench/uut/exec/frwrdb/in3
add wave -noupdate -radix decimal /testbench/uut/exec/frwrdb/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {229914 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
configure wave -valuecolwidth 173
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
WaveRestoreZoom {141656 ps} {289544 ps}
