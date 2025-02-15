module execute (
input rst, Branch1, Branch2, ALUSrc1,ALUSrc2, bne1, bne2,
input [2:0] ForwardA_1, ForwardB_1, ForwardA_2, ForwardB_2,
input [3:0] ALUOp1, ALUOp2,
input [4:0] shamt1_EX, shamt2_EX,
input [31:0] readData1_1, readData2_1, extImm1 ,extImm2 ,readData1_2, readData2_2, aluRes1_MEM, aluRes1_WB,aluRes2_MEM, aluRes2_WB,

output reg [31:0] ForwardB1_EX, ForwardB2_EX,
output [31:0] aluRes1, aluRes2, 
output taken1, taken2

);



reg [31:0] ForwardA1_EX, ForwardA2_EX;
wire [31:0] ALUinB1,ALUinB2; 
wire zero1,zero2;


always @(*) begin
	if(~rst) begin
		ForwardA1_EX = 0;
		ForwardB1_EX = 0;
		ForwardA2_EX = 0;
		ForwardB2_EX = 0;
	end
	else begin
		case (ForwardA_1) 
			3'b000: ForwardA1_EX = readData1_1;
			3'b001: ForwardA1_EX = aluRes1_MEM; // mem 1 should be 1
			3'b010: ForwardA1_EX = aluRes1_WB; // wb 1 should be 2
			3'b011: ForwardA1_EX = aluRes2_MEM; // mem 2 should be 3
			3'b100: ForwardA1_EX = aluRes2_WB; // wb 2 should be 4
			default:ForwardA1_EX = readData1_1;
		endcase
		
		case (ForwardB_1) 
			3'b000: ForwardB1_EX = readData2_1;
			3'b001: ForwardB1_EX = aluRes1_MEM; // mem 1 should be 1
			3'b010: ForwardB1_EX = aluRes1_WB; // wb 1 should be 2
			3'b011: ForwardB1_EX = aluRes2_MEM; // mem 2 should be 3
			3'b100: ForwardB1_EX = aluRes2_WB; // wb 2 should be 4
			default:ForwardB1_EX = readData1_1;
		endcase
		
		case (ForwardA_1) 
			3'b000: ForwardA2_EX = readData1_2;
			3'b001: ForwardA2_EX = aluRes1_MEM; // mem 1 should be 1
			3'b010: ForwardA2_EX = aluRes1_WB; // wb 1 should be 2
			3'b011: ForwardA2_EX = aluRes2_MEM; // mem 2 should be 3
			3'b100: ForwardA2_EX = aluRes2_WB; // wb 2 should be 4
			default:ForwardA2_EX = readData1_1;
		endcase
		
		case (ForwardA_1) 
			3'b000: ForwardB2_EX = readData2_2;
			3'b001: ForwardB2_EX = aluRes1_MEM; // mem 1 should be 1
			3'b010: ForwardB2_EX = aluRes1_WB; // wb 1 should be 2
			3'b011: ForwardB2_EX = aluRes2_MEM; // mem 2 should be 3
			3'b100: ForwardB2_EX = aluRes2_WB; // wb 2 should be 4
			default:ForwardB2_EX = readData1_1;
		endcase
		
	end
end


assign ALUinB1 = ALUSrc1? extImm1 : ForwardB1_EX;
assign ALUinB2 = ALUSrc2? extImm2 : ForwardB2_EX;

ALU alu1(.operand1(ForwardA1_EX), .operand2(ALUinB1), .opSel(ALUOp1), .result(aluRes1), .zero(zero1), .shamt(shamt1_EX));
ALU alu2(.operand1(ForwardA2_EX), .operand2(ALUinB2), .opSel(ALUOp2), .result(aluRes2), .zero(zero2), .shamt(shamt2_EX));


comparator comp1(.In1(ForwardA1_EX),.In2(ForwardB1_EX),.bne(bne1),.branch(Branch1),.branchValid(taken1),.reset(rst),.hold(1'b0));

comparator comp2(.In1(ForwardA2_EX),.In2(ForwardB2_EX),.bne(bne2),.branch(Branch2),.branchValid(taken2),.reset(rst),.hold(1'b0));






endmodule