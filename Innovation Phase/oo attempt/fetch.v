module fetch (
input clk,rst,jr_in, 
input [9:0] jr_address,
output [9:0] PC,
output [31:0] instruction,
output jump, hold
);


wire [9:0] pcplus, j_address;
wire [5:0] opcode;
reg [9:0] pcin;
wire set_hold;

assign pcplus = PC +10'b1;
assign opcode = instruction[31:26];
assign j_address = instruction[9:0];
assign set_hold = (opcode == 6'b0 && instruction[5:0] == 6'h8);
assign jump = opcode == 6'h2;



 

programCounter pc(clk, rst, set_hold,jr_in, pcin,hold, PC);
instructionMemory IM(.address(PC), .clock(~clk), .q(instruction));
/*module programCounter(
    input clk, rst, hold_set, hold_reset,
    input [9:0] PCin,
	 output reg hold,
    output reg [9:0] PCout
);*/


always@(*) begin
	if(~rst) begin
		
		pcin <= pcplus;
	end
	else begin 
		if(opcode == 6'h2 || opcode == 6'h3) pcin <= j_address;
		else if(jr_in) pcin <= jr_address;
		else pcin <= pcplus;
		
		
	end
	
end


endmodule