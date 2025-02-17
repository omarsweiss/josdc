module IFID #(parameter size = 96) (Q, D, clk, reset, hold, flush);
    input clk, reset, hold, flush;
    input [size-1:0] D;
    output reg [size-1:0] Q;
initial begin 
	Q = 200'b0;

end 
    always @(posedge clk or negedge reset) begin
        if (!reset) 
            Q <= 0;  
        else if (flush)
            Q <= 0;  
        else if (!hold) 
            Q <= D;  
    end
endmodule
//////////////////////////////////////////////////////

module IDEX #(parameter size = 153) (Q, D, clk, reset, flush);
input clk, reset, flush;
input [size-1:0] D;
output [size-1:0] Q;
reg [size-1:0] Q;

initial begin 
	Q = 200'b0;

end 
always @(posedge clk, negedge reset)
	begin
     if (!reset)
       Q<=200'b0;
	  else if (flush)
       Q<=0;
     else
       Q<=D;
	end
endmodule
//////////////////////////////////////////////////////

module EXMEM #(parameter size = 106) (Q, D, clk, reset);
input clk, reset;
input [size-1:0] D;
output [size-1:0] Q;
 
reg [size-1:0] Q;
always @(posedge clk, negedge reset)
	begin
     if (~reset) begin 
       Q<=0;
		end
     else begin
	  
       Q<=D;
		 
	  end
	end
endmodule
//////////////////////////////////////////////////////
module MEMWB #(parameter size = 104) (Q, D, clk, reset);
input clk, reset;
input [size-1:0] D;
output [size-1:0] Q;
reg [size-1:0] Q;
always @(posedge clk, negedge reset)
	begin
     if (~reset)
       Q=0;
     else 
       Q=D;
	end
endmodule
