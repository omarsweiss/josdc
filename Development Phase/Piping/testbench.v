`timescale 1ns/1ns
module testbench;

	reg clk, rst;
	
	wire [9:0] PC;
	
	initial begin
		clk = 0;
		rst = 0;
		#4 rst = 1;
		#1000 $stop;
	end
	
	always #5 clk = ~clk;
	
	pipeline uut(clk, rst, PC);
	
	
endmodule
