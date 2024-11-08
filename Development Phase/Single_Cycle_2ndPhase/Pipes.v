module IFID (Q, D, clk, reset);
input clk, reset;
input [95:0] D;
output [95:0] Q;
reg [95:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else 
       Q=D;
	end

endmodule
//////////////////////////////////////////////////////
module IDEX (Q, D, clk, reset);
input clk, reset;
input [152:0] D;
output [152:0] Q;
reg [152:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else
       Q=D;
	end
endmodule
//////////////////////////////////////////////////////

module EXMEM (Q, D, clk, reset);
input clk, reset;
input [105:0] D;
output [105:0] Q;
reg [105:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else 
       Q=D;
	end
endmodule
//////////////////////////////////////////////////////
module MEMWB (Q, D, clk, reset);
input clk, reset, enable;
input [103:0] D;
output [103:0] Q;
reg [103:0] Q;
always @(posedge clk)
	begin
     if (reset == 1)
       Q=0;
     else 
       Q=D;
	end
endmodule
