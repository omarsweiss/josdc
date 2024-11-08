module IFID #(parameter size = 96) (Q, D, clk, reset);
input clk, reset;
input [size-1:0] D;
output [size-1:0] Q;
reg [size-1:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else 
       Q=D;
	end

endmodule
//////////////////////////////////////////////////////
module IDEX #(parameter size = 153) (Q, D, clk, reset);
input clk, reset;
input [size-1:0] D;
output [size-1:0] Q;
reg [size-1:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else
       Q=D;
	end
endmodule
//////////////////////////////////////////////////////

module EXMEM #(parameter size = 106) (Q, D, clk, reset);
input clk, reset;
input [size-1:0] D;
output [size-1:0] Q;
reg [size-1:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else 
       Q=D;
	end
endmodule
//////////////////////////////////////////////////////
module MEMWB #(parameter size = 104) (Q, D, clk, reset);
input clk, reset;
input [size-1:0] D;
output [size-1:0] Q;
reg [size-1:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else 
       Q=D;
	end
endmodule
