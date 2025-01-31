onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate -radix unsigned /testbench/PC
add wave -noupdate /testbench/uut/rf/registers
add wave -noupdate -radix unsigned /testbench/uut/IM/address
add wave -noupdate -radix hexadecimal /testbench/uut/IM/q
add wave -noupdate -radix hexadecimal /testbench/uut/IQ/instr_in
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/uut/IQ/instr_out[31]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[30]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[29]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[28]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[27]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[26]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[25]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[24]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[23]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[22]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[21]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[20]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[19]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[18]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[17]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[16]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[15]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[14]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[13]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[12]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[11]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[10]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[9]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[8]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[7]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[6]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[5]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[4]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[3]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[2]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[1]} -radix hexadecimal} {{/testbench/uut/IQ/instr_out[0]} -radix hexadecimal}} -subitemconfig {{/testbench/uut/IQ/instr_out[31]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[30]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[29]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[28]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[27]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[26]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[25]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[24]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[23]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[22]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[21]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[20]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[19]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[18]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[17]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[16]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[15]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[14]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[13]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[12]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[11]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[10]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[9]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[8]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[7]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[6]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[5]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[4]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[3]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[2]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[1]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/instr_out[0]} {-height 15 -radix hexadecimal}} /testbench/uut/IQ/instr_out
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/uut/IQ/queue[0]} -radix hexadecimal} {{/testbench/uut/IQ/queue[1]} -radix hexadecimal} {{/testbench/uut/IQ/queue[2]} -radix hexadecimal} {{/testbench/uut/IQ/queue[3]} -radix hexadecimal} {{/testbench/uut/IQ/queue[4]} -radix hexadecimal} {{/testbench/uut/IQ/queue[5]} -radix hexadecimal} {{/testbench/uut/IQ/queue[6]} -radix hexadecimal} {{/testbench/uut/IQ/queue[7]} -radix hexadecimal}} -expand -subitemconfig {{/testbench/uut/IQ/queue[0]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/queue[1]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/queue[2]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/queue[3]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/queue[4]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/queue[5]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/queue[6]} {-height 15 -radix hexadecimal} {/testbench/uut/IQ/queue[7]} {-height 15 -radix hexadecimal}} /testbench/uut/IQ/queue
add wave -noupdate /testbench/uut/IQ/enqueue
add wave -noupdate /testbench/uut/IQ/head
add wave -noupdate /testbench/uut/IQ/tail
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8347 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 234
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {90079 ps}
