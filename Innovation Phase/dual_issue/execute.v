module execute (
input rst, Branch1, Branch2, ALUSrc1,ALUSrc2, bne1, bne2,
input [3:0] ALUOp1, ALUOp2,
input [4:0] shamt1_EX, shamt2_EX,
input [31:0] readData1_1, readData2_1, extImm1 ,extImm2 ,readData1_2, readData2_2,

output [31:0] aluRes1, aluRes2, 
output taken1, taken2

);



reg [31:0] ForwardA1_EX, ForwardA2_EX;
wire [31:0] ALUinB1,ALUinB2; 
wire zero1,zero2;



assign ALUinB1 = ALUSrc1? extImm1 : readData2_1;
assign ALUinB2 = ALUSrc2? extImm2 : readData2_2;

ALU alu1(.operand1(readData1_1), .operand2(ALUinB1), .opSel(ALUOp1), .result(aluRes1), .zero(zero1), .shamt(shamt1_EX));
ALU alu2(.operand1(readData1_2), .operand2(ALUinB2), .opSel(ALUOp2), .result(aluRes2), .zero(zero2), .shamt(shamt2_EX));


comparator comp1(.In1(readData1_1),.In2(readData2_1),.bne(bne1),.branch(Branch1),.branchValid(taken1),.reset(rst),.hold(1'b0));

comparator comp2(.In1(readData1_2),.In2(readData2_2),.bne(bne2),.branch(Branch2),.branchValid(taken2),.reset(rst),.hold(1'b0));






endmodule