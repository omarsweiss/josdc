onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate -radix decimal /testbench/PC
add wave -noupdate -radix hexadecimal /testbench/uut/IM/q
add wave -noupdate -radix decimal {/testbench/uut/RF/registers[4]}
add wave -noupdate -radix decimal {/testbench/uut/RF/registers[5]}
add wave -noupdate -radix decimal {/testbench/uut/RF/registers[6]}
add wave -noupdate -radix decimal {/testbench/uut/RF/registers[7]}
add wave -noupdate -radix decimal {/testbench/uut/RF/registers[8]}
add wave -noupdate -radix decimal {/testbench/uut/RF/registers[9]}
add wave -noupdate -divider ALU
add wave -noupdate -radix hexadecimal /testbench/uut/alu/operand1
add wave -noupdate -radix hexadecimal /testbench/uut/alu/operand2
add wave -noupdate -radix hexadecimal /testbench/uut/alu/opSel
add wave -noupdate -radix hexadecimal /testbench/uut/alu/result
add wave -noupdate /testbench/uut/alu/zero
add wave -noupdate -radix decimal /testbench/uut/WBMux/in1
add wave -noupdate -radix decimal -childformat {{{/testbench/uut/WBMux/in2[31]} -radix decimal} {{/testbench/uut/WBMux/in2[30]} -radix decimal} {{/testbench/uut/WBMux/in2[29]} -radix decimal} {{/testbench/uut/WBMux/in2[28]} -radix decimal} {{/testbench/uut/WBMux/in2[27]} -radix decimal} {{/testbench/uut/WBMux/in2[26]} -radix decimal} {{/testbench/uut/WBMux/in2[25]} -radix decimal} {{/testbench/uut/WBMux/in2[24]} -radix decimal} {{/testbench/uut/WBMux/in2[23]} -radix decimal} {{/testbench/uut/WBMux/in2[22]} -radix decimal} {{/testbench/uut/WBMux/in2[21]} -radix decimal} {{/testbench/uut/WBMux/in2[20]} -radix decimal} {{/testbench/uut/WBMux/in2[19]} -radix decimal} {{/testbench/uut/WBMux/in2[18]} -radix decimal} {{/testbench/uut/WBMux/in2[17]} -radix decimal} {{/testbench/uut/WBMux/in2[16]} -radix decimal} {{/testbench/uut/WBMux/in2[15]} -radix decimal} {{/testbench/uut/WBMux/in2[14]} -radix decimal} {{/testbench/uut/WBMux/in2[13]} -radix decimal} {{/testbench/uut/WBMux/in2[12]} -radix decimal} {{/testbench/uut/WBMux/in2[11]} -radix decimal} {{/testbench/uut/WBMux/in2[10]} -radix decimal} {{/testbench/uut/WBMux/in2[9]} -radix decimal} {{/testbench/uut/WBMux/in2[8]} -radix decimal} {{/testbench/uut/WBMux/in2[7]} -radix decimal} {{/testbench/uut/WBMux/in2[6]} -radix decimal} {{/testbench/uut/WBMux/in2[5]} -radix decimal} {{/testbench/uut/WBMux/in2[4]} -radix decimal} {{/testbench/uut/WBMux/in2[3]} -radix decimal} {{/testbench/uut/WBMux/in2[2]} -radix decimal} {{/testbench/uut/WBMux/in2[1]} -radix decimal} {{/testbench/uut/WBMux/in2[0]} -radix decimal}} -subitemconfig {{/testbench/uut/WBMux/in2[31]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[30]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[29]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[28]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[27]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[26]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[25]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[24]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[23]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[22]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[21]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[20]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[19]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[18]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[17]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[16]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[15]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[14]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[13]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[12]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[11]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[10]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[9]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[8]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[7]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[6]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[5]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[4]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[3]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[2]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[1]} {-height 15 -radix decimal} {/testbench/uut/WBMux/in2[0]} {-height 15 -radix decimal}} /testbench/uut/WBMux/in2
add wave -noupdate -radix decimal /testbench/uut/WBMux/out
add wave -noupdate -radix decimal /testbench/uut/WBMux/s
add wave -noupdate -radix hexadecimal /testbench/uut/RFMux/in1
add wave -noupdate -radix hexadecimal /testbench/uut/RFMux/in2
add wave -noupdate -radix hexadecimal /testbench/uut/RFMux/out
add wave -noupdate -radix hexadecimal /testbench/uut/RFMux/s
add wave -noupdate -divider {Register File}
add wave -noupdate -radix hexadecimal /testbench/uut/RF/writeData
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/uut/RF/registers[0]} -radix hexadecimal} {{/testbench/uut/RF/registers[1]} -radix hexadecimal} {{/testbench/uut/RF/registers[2]} -radix hexadecimal} {{/testbench/uut/RF/registers[3]} -radix hexadecimal} {{/testbench/uut/RF/registers[4]} -radix hexadecimal} {{/testbench/uut/RF/registers[5]} -radix hexadecimal} {{/testbench/uut/RF/registers[6]} -radix hexadecimal} {{/testbench/uut/RF/registers[7]} -radix hexadecimal} {{/testbench/uut/RF/registers[8]} -radix hexadecimal} {{/testbench/uut/RF/registers[9]} -radix hexadecimal} {{/testbench/uut/RF/registers[10]} -radix hexadecimal} {{/testbench/uut/RF/registers[11]} -radix hexadecimal} {{/testbench/uut/RF/registers[12]} -radix hexadecimal} {{/testbench/uut/RF/registers[13]} -radix hexadecimal} {{/testbench/uut/RF/registers[14]} -radix hexadecimal} {{/testbench/uut/RF/registers[15]} -radix hexadecimal} {{/testbench/uut/RF/registers[16]} -radix hexadecimal} {{/testbench/uut/RF/registers[17]} -radix hexadecimal} {{/testbench/uut/RF/registers[18]} -radix hexadecimal} {{/testbench/uut/RF/registers[19]} -radix hexadecimal} {{/testbench/uut/RF/registers[20]} -radix hexadecimal} {{/testbench/uut/RF/registers[21]} -radix hexadecimal} {{/testbench/uut/RF/registers[22]} -radix hexadecimal} {{/testbench/uut/RF/registers[23]} -radix hexadecimal} {{/testbench/uut/RF/registers[24]} -radix hexadecimal} {{/testbench/uut/RF/registers[25]} -radix hexadecimal} {{/testbench/uut/RF/registers[26]} -radix hexadecimal} {{/testbench/uut/RF/registers[27]} -radix hexadecimal} {{/testbench/uut/RF/registers[28]} -radix hexadecimal} {{/testbench/uut/RF/registers[29]} -radix hexadecimal} {{/testbench/uut/RF/registers[30]} -radix hexadecimal} {{/testbench/uut/RF/registers[31]} -radix hexadecimal}} -subitemconfig {{/testbench/uut/RF/registers[0]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[1]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[2]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[3]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[4]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[5]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[6]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[7]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[8]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[9]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[10]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[11]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[12]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[13]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[14]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[15]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[16]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[17]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[18]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[19]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[20]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[21]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[22]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[23]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[24]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[25]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[26]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[27]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[28]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[29]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[30]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/registers[31]} {-height 15 -radix hexadecimal}} /testbench/uut/RF/registers
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/uut/RF/writeRegister[4]} -radix hexadecimal} {{/testbench/uut/RF/writeRegister[3]} -radix hexadecimal} {{/testbench/uut/RF/writeRegister[2]} -radix hexadecimal} {{/testbench/uut/RF/writeRegister[1]} -radix hexadecimal} {{/testbench/uut/RF/writeRegister[0]} -radix hexadecimal}} -subitemconfig {{/testbench/uut/RF/writeRegister[4]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/writeRegister[3]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/writeRegister[2]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/writeRegister[1]} {-height 15 -radix hexadecimal} {/testbench/uut/RF/writeRegister[0]} {-height 15 -radix hexadecimal}} /testbench/uut/RF/writeRegister
add wave -noupdate -radix hexadecimal /testbench/uut/RF/readData1
add wave -noupdate -radix hexadecimal /testbench/uut/RF/readData2
add wave -noupdate -radix hexadecimal /testbench/uut/RF/readRegister1
add wave -noupdate -radix hexadecimal /testbench/uut/RF/readRegister2
add wave -noupdate -radix hexadecimal /testbench/uut/RF/rst
add wave -noupdate -radix hexadecimal /testbench/uut/RF/we
add wave -noupdate -divider {Data Memory}
add wave -noupdate -radix hexadecimal /testbench/uut/DM/data
add wave -noupdate -radix hexadecimal /testbench/uut/DM/address
add wave -noupdate -radix hexadecimal /testbench/uut/DM/q
add wave -noupdate -radix hexadecimal /testbench/uut/DM/rden
add wave -noupdate -radix hexadecimal /testbench/uut/DM/wren
add wave -noupdate -divider {Control Unit}
add wave -noupdate -radix hexadecimal /testbench/uut/CU/ALUOp
add wave -noupdate -radix hexadecimal /testbench/uut/CU/ALUSrc
add wave -noupdate -radix hexadecimal /testbench/uut/CU/Branch
add wave -noupdate -radix hexadecimal /testbench/uut/CU/RegWriteEn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29352 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {61219 ps}