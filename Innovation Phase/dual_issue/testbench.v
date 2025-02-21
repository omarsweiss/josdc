`timescale 1ns/1ns
module testbench;

	reg clk, rst;
	
	wire [31:0] out1,out2;
	
	initial begin
		clk = 1;
		rst = 0;
		#4 rst = 1;
		#39000 $stop;
	end
	
	always #5 clk = ~clk;
	
	Dual_Issue uut(clk, rst, out1,out2);
	
	
endmodule
