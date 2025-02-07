onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate -radix unsigned /testbench/uut/fetch/PC
add wave -noupdate -radix decimal /testbench/uut/fetch/IM/address
add wave -noupdate -radix unsigned /testbench/uut/fetch/nextPC
add wave -noupdate /testbench/uut/fetch/taken
add wave -noupdate -radix hexadecimal /testbench/uut/fetch/instruction
add wave -noupdate -radix decimal /testbench/uut/PCPlus1
add wave -noupdate -divider Decode
add wave -noupdate -radix hexadecimal /testbench/uut/dcd/opCode
add wave -noupdate -radix decimal /testbench/uut/PCPlus1_ID
add wave -noupdate /testbench/uut/dcd/ALUOp
add wave -noupdate /testbench/uut/ALUOp_EX
add wave -noupdate /testbench/uut/idex/flush
add wave -noupdate /testbench/uut/dcd/ALUSrc
add wave -noupdate /testbench/uut/dcd/Branch
add wave -noupdate -radix unsigned /testbench/uut/dcd/DestReg
add wave -noupdate /testbench/uut/dcd/MemReadEn
add wave -noupdate /testbench/uut/dcd/MemWriteEn
add wave -noupdate /testbench/uut/dcd/MemtoReg
add wave -noupdate /testbench/uut/dcd/RegDst
add wave -noupdate /testbench/uut/dcd/RegWriteEn
add wave -noupdate /testbench/uut/dcd/jal
add wave -noupdate /testbench/uut/dcd/jal_WB
add wave -noupdate /testbench/uut/dcd/jr
add wave -noupdate -divider RF
add wave -noupdate -radix decimal /testbench/uut/PCPlus1_WB
add wave -noupdate -radix decimal -childformat {{{/testbench/uut/dcd/RF/registers[0]} -radix decimal} {{/testbench/uut/dcd/RF/registers[1]} -radix decimal} {{/testbench/uut/dcd/RF/registers[2]} -radix decimal} {{/testbench/uut/dcd/RF/registers[3]} -radix decimal} {{/testbench/uut/dcd/RF/registers[4]} -radix decimal} {{/testbench/uut/dcd/RF/registers[5]} -radix decimal} {{/testbench/uut/dcd/RF/registers[6]} -radix decimal} {{/testbench/uut/dcd/RF/registers[7]} -radix decimal} {{/testbench/uut/dcd/RF/registers[8]} -radix decimal} {{/testbench/uut/dcd/RF/registers[9]} -radix decimal} {{/testbench/uut/dcd/RF/registers[10]} -radix decimal} {{/testbench/uut/dcd/RF/registers[11]} -radix decimal} {{/testbench/uut/dcd/RF/registers[12]} -radix decimal} {{/testbench/uut/dcd/RF/registers[13]} -radix decimal} {{/testbench/uut/dcd/RF/registers[14]} -radix decimal} {{/testbench/uut/dcd/RF/registers[15]} -radix decimal} {{/testbench/uut/dcd/RF/registers[16]} -radix decimal} {{/testbench/uut/dcd/RF/registers[17]} -radix decimal} {{/testbench/uut/dcd/RF/registers[18]} -radix decimal} {{/testbench/uut/dcd/RF/registers[19]} -radix decimal} {{/testbench/uut/dcd/RF/registers[20]} -radix decimal} {{/testbench/uut/dcd/RF/registers[21]} -radix decimal} {{/testbench/uut/dcd/RF/registers[22]} -radix decimal} {{/testbench/uut/dcd/RF/registers[23]} -radix decimal} {{/testbench/uut/dcd/RF/registers[24]} -radix decimal} {{/testbench/uut/dcd/RF/registers[25]} -radix decimal} {{/testbench/uut/dcd/RF/registers[26]} -radix decimal} {{/testbench/uut/dcd/RF/registers[27]} -radix decimal} {{/testbench/uut/dcd/RF/registers[28]} -radix decimal} {{/testbench/uut/dcd/RF/registers[29]} -radix decimal} {{/testbench/uut/dcd/RF/registers[30]} -radix decimal} {{/testbench/uut/dcd/RF/registers[31]} -radix decimal}} -expand -subitemconfig {{/testbench/uut/dcd/RF/registers[0]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[1]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[2]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[3]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[4]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[5]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[6]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[7]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[8]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[9]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[10]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[11]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[12]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[13]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[14]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[15]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[16]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[17]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[18]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[19]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[20]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[21]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[22]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[23]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[24]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[25]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[26]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[27]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[28]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[29]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[30]} {-height 15 -radix decimal} {/testbench/uut/dcd/RF/registers[31]} {-height 15 -radix decimal}} /testbench/uut/dcd/RF/registers
add wave -noupdate -divider Execute
add wave -noupdate -radix decimal /testbench/uut/PCPlus1_EX
add wave -noupdate -radix binary /testbench/uut/exec/forwardA
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/in1
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/in2
add wave -noupdate -radix decimal /testbench/uut/exec/frwrda/in3
add wave -noupdate -radix binary /testbench/uut/exec/forwardB
add wave -noupdate -radix decimal /testbench/uut/exec/frwrdb/in1
add wave -noupdate -radix decimal /testbench/uut/exec/frwrdb/in2
add wave -noupdate -radix decimal /testbench/uut/exec/frwrdb/in3
add wave -noupdate -radix binary /testbench/uut/exec/ALUOp
add wave -noupdate -radix decimal /testbench/uut/exec/alu/operand1
add wave -noupdate -radix decimal /testbench/uut/exec/alu/operand2
add wave -noupdate -radix decimal /testbench/uut/exec/aluRizz_EX
add wave -noupdate /testbench/uut/exec/taken
add wave -noupdate /testbench/uut/exec/bne
add wave -noupdate /testbench/uut/exec/Branch
add wave -noupdate /testbench/uut/exec/taken
add wave -noupdate /testbench/uut/exec/zero
add wave -noupdate -divider fw
add wave -noupdate -radix decimal /testbench/uut/fw/dest_mem
add wave -noupdate -radix decimal /testbench/uut/fw/regwrite_mem
add wave -noupdate -radix decimal /testbench/uut/fw/rs_ex
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {56717 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 135
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix -1
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 5000
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {147150 ps}
