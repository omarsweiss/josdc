module decode(input clk, rst, RegWriteEn_WB, jal_WB,
input [31:0] instruction, writeData_WB,
input [4:0] writeRegister_WB, 

output [4:0] shamt, rs, rt, DestReg,
output Branch, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc, jr, jal,RegDst,bne,
output [3:0] ALUOp, 
output [31:0] readData1, readData2, extImm);


wire [5:0] opCode, funct;
wire [4:0] rd, writeRegister, regAddress;
wire [15:0] imm;





assign opCode = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign imm = instruction[15:0];
assign funct = instruction[5:0];
assign shamt = instruction[10:6];




controlUnit CU(.opCode(opCode), .funct(funct), 
.RegDst(RegDst), .Branch(Branch), .MemReadEn(MemReadEn), .MemtoReg(MemtoReg),
.ALUOp(ALUOp), .MemWriteEn(MemWriteEn), .RegWriteEn(RegWriteEn), .ALUSrc(ALUSrc),
.bne(bne),.jal(jal),.jr(jr));



mux2x1 #(5) RFMux(.in1(rt), .in2(rd), .s(RegDst), .out(DestReg));
	
mux2x1 #(5) RegWriteMux(.in1(writeRegister_WB),.in2(5'd31),.s(jal_WB),.out(regAddress)); 

registerFile RF(.clk(clk), .rst(rst), .we(RegWriteEn_WB), 
				    .readRegister1(rs), .readRegister2(rt), .writeRegister(regAddress),
				    .writeData(writeData_WB), .readData1(readData1), .readData2(readData2));
				
					 
SignExtender SignExtend(.in(imm), .out(extImm));







endmodule

/*
adder branchAdder(.in1(PCPlus1), .in2(imm[9:0]), .out(adderResult));


mux4x1 #(32) FrdAmux (.in1(readData1), .in2(aluRes_MEM), .in3(writeData_WB), .in4(32'b0), .s(ForwardA_branch), .out(fwdA));

mux4x1 #(32) FrdBmux (.in1(readData2), .in2(aluRes_MEM), .in3(writeData_WB), .in4(32'b0), .s(ForwardB_branch), .out(fwdB));

comparator cmp(
	.In1(fwdA),
	.In2(fwdB),
	.bne(bne),
	.reset(rst),
	.hold(hold),
	.branch(Branch),
	.branchValid(PCSrc)
);
	*/