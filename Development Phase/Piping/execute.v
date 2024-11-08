module execute(input [31:0] readData1, input [31:0] readData2, input [31:0] aluRes_MEM, input [31:0] aluRes_WB, input [31:0] extImm,
input [3:0] ALUOp, input ALUSrc, input [1:0] forwardA, input [1:0] forwardB, input [4:0] shamt_EX,
output [31:0] aluRizz_EX, output [31:0] forwardBRizz_EX);


wire [31:0] ALUin2, forwardARizz;



mux4x1 #(32) frwrda(.in1(readData1), .in2(aluRes_WB), .in3(aluRes_MEM), .in4(32'b0), .s(forwardA), .out(forwardARizz));
mux4x1 #(32) frwrdb(.in1(readData2), .in2(aluRes_WB), .in3(aluRes_MEM), .in4(32'b0), .s(forwardB), .out(forwardBRizz_EX));


mux2x1 #(32) ALUMux(.in1(forwardBRizz_EX), .in2(extImm), .s(ALUSrc), .out(ALUin2)); 
	
ALU alu(.operand1(forwardARizz), .operand2(ALUin2), .opSel(ALUOp), .result(aluRizz_EX), .zero(), .shamt(shamt_EX));



















endmodule