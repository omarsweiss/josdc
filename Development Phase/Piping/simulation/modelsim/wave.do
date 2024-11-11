onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/PC
add wave -noupdate -radix decimal /testbench/clk
add wave -noupdate -radix decimal /testbench/rst
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
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/bne
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/branch
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/branchValid
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/In1
add wave -noupdate -radix unsigned /testbench/uut/dcd/cmp/In2
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
WaveRestoreCursors {{Cursor 1} {319159 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 224
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
WaveRestoreZoom {259096 ps} {354134 ps}
