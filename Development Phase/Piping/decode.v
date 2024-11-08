module decode(input clk, input rst,
input [31:0] instruction, input RegWriteEn_WB, input [31:0] writeData_WB, input [4:0] writeRegister_WB, input [9:0] PCPlus1, input jal_WB,

output [9:0] jaddress, output [4:0] shamt, output Branch, output MemReadEn, output MemtoReg, output MemWriteEn, output RegWriteEn, output ALUSrc, output jump, output jr, output jal,
output [3:0] ALUOp, output [4:0] rs, output [4:0] rt, 
output [4:0] DestReg, output [31:0] readData1, output [31:0] readData2, output [31:0] extImm, output [9:0] adderResult, output PCSrc);


wire [5:0] opCode, funct;
wire [4:0] rd, writeRegister, regAddress;
wire [15:0] imm;
wire RegDst, bne;







assign opCode = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign imm = instruction[15:0];
assign funct = instruction[5:0];
assign shamt = instruction[10:6];
assign jaddress = instruction[9:0];





controlUnit CU(.opCode(opCode), .funct(funct), 
.RegDst(RegDst), .Branch(Branch), .MemReadEn(MemReadEn), .MemtoReg(MemtoReg),
.ALUOp(ALUOp), .MemWriteEn(MemWriteEn), .RegWriteEn(RegWriteEn), .ALUSrc(ALUSrc),
.bne(bne),.jump(jump),.jal(jal),.jr(jr));





mux2x1 #(5) RFMux(.in1(rt), .in2(rd), .s(RegDst), .out(DestReg));
	
mux2x1 #(5) RegWriteMux(.in1(writeRegister_WB),.in2(5'd31),.s(jal_WB),.out(regAddress)); 

registerFile RF(.clk(clk), .rst(rst), .we(RegWriteEn_WB), 
				    .readRegister1(rs), .readRegister2(rt), .writeRegister(regAddress),
				    .writeData(writeData_WB), .readData1(readData1), .readData2(readData2));
					 
SignExtender SignExtend(.in(imm), .out(extImm));
adder branchAdder(.in1(PCPlus1), .in2(imm[9:0]), .out(adderResult));


comparator cmp(
	.In1(readData1),
	.In2(readData2),
	.bne(bne),
	.reset(rst),
	.branchValid(PCSrc)
);
	




endmodule