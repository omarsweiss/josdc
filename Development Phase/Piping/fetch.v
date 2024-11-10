module fetch(
input clk, rst, PCsrc, jr, jump,
input [9:0] reg1Addr, jaddress,adderResult,

output [9:0] PCPlus1, PC, 
output [31:0] instruction);

wire [9:0] branchAddress, jrAddress, nextPC;  

//outermost mux
mux2x1 #(10) PCMux(.in1(PCPlus1), .in2(adderResult), .s(PCsrc), .out(branchAddress));//0 gives in1 1 gives in2, changed name from nextPC to branchaddress for jump implementation
//	jump or jr
mux2x1 #(10) JRMux(.in1(jaddress),.in2(reg1Addr),.s(jr),.out(jrAddress));
//branch or jump address
mux2x1 #(10) jumpMux(.in1(branchAddress),.in2(jrAddress),.s(jump),.out(nextPC));

programCounter pc(.clk(clk), .rst(rst), .PCin(nextPC), .PCout(PC));
adder PCAdder(.in1(PC), .in2(10'b1), .out(PCPlus1));
instructionMemory IM(.address(nextPC), .clock(clk), .q(instruction));







endmodule


//programCounter pc(.clk(clk), .rst(rst), .PCin(nextPC), .PCout(PC)); // talk abt pc in free space

//adder PCAdder(.in1(PC), .in2(10'b1), .out(PCPlus1));	
	
//instructionMemory IM(.address(nextPC), .clock(clk), .q(instruction));