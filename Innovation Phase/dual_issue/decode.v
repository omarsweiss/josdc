module decode(
input clk, rst, jal1_WB,jal2_WB, regWrite1_WB, regWrite2_WB,
input [4:0] writeReg1_WB, writeReg2_WB,
input [31:0] instruction1, instruction2, writeData1_WB, writeData2_WB,
 
output[4:0] shamt1, shamt2, rs1, rt1, rs2, rt2, destReg1,destReg2,
output Branch1, MemReadEn1, MemtoReg1, MemWriteEn1, RegWriteEn1, ALUSrc1, jr1, jal1, RegDst1, bne1,jump1,
 Branch2, MemReadEn2, MemtoReg2, MemWriteEn2, RegWriteEn2, ALUSrc2, jr2, jal2, RegDst2, bne2,jump2,
output [3:0] AluOp1,AluOp2, 
output [31:0] readData1_1, readData2_1, extImm1,readData1_2, readData2_2, extImm2
);



wire [5:0] opCode1, funct1,opCode2, funct2;
wire [4:0] rd1, writeRegister1, regAddress1, rd2, writeRegister2, regAddress2;
wire [15:0] imm1,imm2;

assign opCode1 = instruction1[31:26];
assign rs1 = instruction1[25:21];
assign rt1 = instruction1[20:16];
assign rd1 = instruction1[15:11];
assign imm1 = instruction1[15:0];
assign funct1 = instruction1[5:0];
assign shamt1 = instruction1[10:6];

assign opCode2 = instruction2[31:26];
assign rs2 = instruction2[25:21];
assign rt2 = instruction2[20:16];
assign rd2 = instruction2[15:11];
assign imm2 = instruction2[15:0];
assign funct2 = instruction2[5:0];
assign shamt2 = instruction2[10:6];


controlUnit CU1(.opCode(opCode1), .funct(funct1), 
.RegDst(RegDst1), .Branch(Branch1), .MemReadEn(MemReadEn1), .MemtoReg(MemtoReg1),
.ALUOp(AluOp1), .MemWriteEn(MemWriteEn1), .RegWriteEn(RegWriteEn1), .ALUSrc(ALUSrc1),
.bne(bne1),.jump(jump1),.jal(jal1),.jr(jr1));

controlUnit CU2(.opCode(opCode2), .funct(funct2), 
.RegDst(RegDst2), .Branch(Branch2), .MemReadEn(MemReadEn2), .MemtoReg(MemtoReg2),
.ALUOp(AluOp2), .MemWriteEn(MemWriteEn2), .RegWriteEn(RegWriteEn2), .ALUSrc(ALUSrc2),
.bne(bne2),.jump(jump2),.jal(jal2),.jr(jr2));


assign destReg1 = RegDst1? rd1: rt1;

assign destReg2 = RegDst2? rd2: rt2;

assign regAddress1 = jal1_WB ? 5'd31 : writeReg1_WB;

assign regAddress2 = jal2_WB ? 5'd31 : writeReg2_WB;



registerFile rf(.clk(clk), .rst(rst),.we1(regWrite1_WB), .we2(regWrite2_WB), 

					 .readRegister1_1(rs1), .readRegister2_1(rt1),.readRegister1_2(rs2), .readRegister2_2(rt2),
					 
					 .writeRegister1(regAddress1),.writeRegister2(regAddress2),
					 
					 .writeData1(writeData1_WB),.writeData2(writeData1_WB),
					 
					 .readData1_1(readData1_1), .readData2_1(readData2_1), .readData1_2(readData1_2), .readData2_2(readData2_2));
					 
					 
SignExtender SignExtend1(.in(imm1), .out(extImm1));
					 
SignExtender SignExtend2(.in(imm2), .out(extImm2));

endmodule