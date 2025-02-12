`timescale 1ns/1ns
module testbench;

	reg clk, rst;
	
	wire [7:0] PC;
	
	initial begin
		clk = 1;
		rst = 0;
		#4 rst = 1;
		#1000 $stop;
	end
	
	always #5 clk = ~clk;
	
	processor uut(clk, rst, PC);
	
	
endmodule
