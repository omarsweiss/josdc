module execute(
input ALUSrc, Branch, bne,
input [1:0] forwardA, forwardB, 
input [3:0] ALUOp,
input [4:0] shamt_EX,
input [31:0] readData1, readData2, aluRes_MEM, aluRes_WB, extImm,


output [31:0] aluRizz_EX, forwardBRizz_EX, 
output taken);


wire [31:0] ALUin2, forwardARizz;
wire zero;


mux4x1 #(32) frwrda(.in1(readData1), .in2(aluRes_WB), .in3(aluRes_MEM), .in4(32'b0), .s(forwardA), .out(forwardARizz));
mux4x1 #(32) frwrdb(.in1(readData2), .in2(aluRes_WB), .in3(aluRes_MEM), .in4(32'b0), .s(forwardB), .out(forwardBRizz_EX));


mux2x1 #(32) ALUMux(.in1(forwardBRizz_EX), .in2(extImm), .s(ALUSrc), .out(ALUin2)); 
	
ALU alu(.operand1(forwardARizz), .operand2(ALUin2), .opSel(ALUOp), .result(aluRizz_EX), .zero(zero), .shamt(shamt_EX));


comparator comp(.In1(forwardARizz),.In2(ALUin2),.bne(bne),.branch(Branch),.branchValid(taken),.reset(),.hold());


endmodule