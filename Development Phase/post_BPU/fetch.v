module fetch(
input clk, rst, taken, jr, hold,Branch_EX,
input [9:0] reg1Addr,PCPlus1_EX, BranchAddress,

output [9:0] PCPlus1, PC, 
output [31:0] instruction);

reg [9:0] nextPC;
wire [9:0] branchAddress, address;   
wire [5:0] opCode;


assign opCode = instruction[31:26];
assign address = instruction[9:0];



always @(*) begin
	if(~rst) nextPC <= 10'b0000000000;
	else if (!taken & Branch_EX) nextPC <= PCPlus1_EX;
	else if (jr) nextPC <= reg1Addr;
	else if (opCode == 6'h2 || opCode == 6'h3) nextPC <= address;
	else if (opCode == 6'h4 || opCode == 6'h5) nextPC <= address + PCPlus1;
	else nextPC <= PCPlus1;
end




adder PCAdder(.in1(PC), .in2(10'b1), .out(PCPlus1));

programCounter pc(.clk(clk), .rst(rst), .PCin(nextPC), .PCout(PC), .hold(hold));

instructionMemory IM(.address(PC), .clock(~clk), .q(instruction));







endmodule

/*
//outermost mux
mux2x1 #(10) PCMux(.in1(PCPlus1), .in2(adderResult), .s(PCsrc), .out(branchAddress));//0 gives in1 1 gives in2, changed name from nextPC to branchaddress for jump implementation
//	jump or jr
mux2x1 #(10) JRMux(.in1(jaddress),.in2(reg1Addr),.s(jr),.out(jrAddress));
//branch or jump address
mux2x1 #(10) jumpMux(.in1(branchAddress),.in2(jrAddress),.s(jump),.out(nextPC));
*/