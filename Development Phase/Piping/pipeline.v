module pipeline(input clk, input rst, output [9:0] PC);




wire [31:0] instruction, writeData_WB, readData1, readData2, extImm, readData1_EX, readData2_EX, memoryReadData_WB, WBMuxOutput, 
extImm_EX, aluRes_EX, forwardBRes_EX, aluRes_MEM, aluRes_WB, forwardBRes_MEM, instruction_ID,memoryReadData;
wire [9:0] reg1Addr, jaddress, adderResult, PCPlus1, PC_ID, PCPlus1_ID, jaddress_ID, adderResult_ID, PCPlus1_EX, PCPlus1_MEM, PCPlus1_WB;
wire [4:0] shamt, rs, rt, DestReg, shamt_EX, rs_EX, rt_EX, DestReg_EX, DestReg_MEM, DestReg_WB;
wire [3:0] ALUOp, ALUOp_EX;
wire [1:0] forwardA, forwardB, fwdAbranch, fwdBbranch;
wire PCSrc, jr, RegWriteEn_WB, Branch, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc, RegDst,
jump, jal,  MemReadEn_EX, MemtoReg_EX, MemWriteEn_EX, RegWriteEn_EX, ALUSrc_EX, jal_EX, ld_hazard, branch_hazard, hold,
MemReadEn_MEM, MemtoReg_MEM, MemWriteEn_MEM, RegWriteEn_MEM, ALUSrc_MEM, jal_MEM, jal_WB, MemtoReg_WB;


  




fetch fetch(
.clk(clk), .rst(rst),  .reg1Addr(reg1Addr), .jaddress(jaddress), . hold(hold),
.PCsrc(PCSrc), .jr(jr),  .jump(jump), .adderResult(adderResult),
.PCPlus1(PCPlus1), .PC(PC), .instruction(instruction));



IFID #(52) ifid(.Q({PCPlus1_ID, PC_ID, instruction_ID}), .D({PCPlus1, PC, instruction}), .clk(clk), .reset(rst), .hold(hold), .flush(branch_hazard));

decode dcd(.clk(clk), .rst(rst), 
.instruction(instruction_ID), .RegWriteEn_WB(RegWriteEn_WB), .writeRegister_WB(DestReg_WB), .PCPlus1(PCPlus1_ID),
.jaddress(jaddress), .shamt(shamt), .Branch(Branch), .MemReadEn(MemReadEn), .MemtoReg(MemtoReg), .MemWriteEn(MemWriteEn), .RegWriteEn(RegWriteEn), .ALUSrc(ALUSrc), .jump(jump), 
.jr(jr), .jal(jal), .jal_WB(jal_WB), .aluRes_MEM(aluRes_MEM), .writeData_WB(writeData_WB), .ForwardA_branch(fwdAbranch), .ForwardB_branch(fwdBbranch),
.ALUOp(ALUOp), .rs(rs), .rt(rt), .RegDst(RegDst),
.DestReg(DestReg), .readData1(readData1), .readData2(readData2), .extImm(extImm), .adderResult(adderResult), .PCSrc(PCSrc));



hazard_detection HDU(
  
  .rs_ID(rs), .rt_ID(rt), .dest_MEM(DestReg_MEM), .dest_EXE(DestReg_EX), .dest_WB(DestReg_WB), 
  .mem_read_EX(MemReadEn_EX),.branch(Branch), .branchValid(PCSrc), .writeBack_MEM(RegWriteEn_MEM), .writeBack_EX(RegWriteEn_EX), .writeBack_WB(RegWriteEn_WB),
  .mem_to_reg_MEM(MemtoReg_MEM), .regDest_ID(RegDst), .jump(jump), .jr(jr), .jal(jal),
  
  .ld_has_hazard(ld_hazard), .branch_has_hazard(branch_hazard), .hold(hold),
  .forwardA_Branch(fwdAbranch), .forwardB_Branch(fwdBbranch));


IDEX #(136) idex(.Q({shamt_EX, MemReadEn_EX, MemtoReg_EX, MemWriteEn_EX, RegWriteEn_EX, ALUSrc_EX, jal_EX, ALUOp_EX, rs_EX, rt_EX, DestReg_EX, readData1_EX, readData2_EX, extImm_EX, PCPlus1_EX}), 
.D({shamt, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc, jal, ALUOp, rs, rt, DestReg, readData1, readData2, extImm, PCPlus1_ID}), 
.clk(clk), .reset(rst), .flush(ld_hazard));



execute exec(
    .readData1(readData1_EX), .readData2(readData2_EX), .aluRes_MEM(aluRes_MEM), 
    .aluRes_WB(WBMuxOutput), .extImm(extImm_EX), .ALUOp(ALUOp_EX), .ALUSrc(ALUSrc_EX), 
    .forwardA(forwardA), .forwardB(forwardB), .shamt_EX(shamt_EX), 
    .aluRizz_EX(aluRes_EX), .forwardBRizz_EX(forwardBRes_EX)
);

forwarding_unit fw(
  .rs_ex(rs_EX),
  .rt_ex(rt_EX),
  .dest_mem(DestReg_MEM),
  .dest_wb(DestReg_WB),
  .rst(rst),
  .regwrite_mem(RegWriteEn_MEM),
  .regwrite_wb(RegWriteEn_WB),
  
  .ForwardA(forwardA),
  .ForwardB(forwardB));




EXMEM #(84) exmem(
    .Q({aluRes_MEM, forwardBRes_MEM, MemReadEn_MEM, MemtoReg_MEM, MemWriteEn_MEM, RegWriteEn_MEM, jal_MEM, DestReg_MEM, PCPlus1_MEM}), 
    .D({aluRes_EX, forwardBRes_EX, MemReadEn_EX, MemtoReg_EX, MemWriteEn_EX, RegWriteEn_EX,  jal_EX, DestReg_EX, PCPlus1_EX}), 
    .clk(clk), .reset(rst)
);

dataMemory DM(.address(aluRes_MEM[7:0]), .clock(~clk), .data(forwardBRes_MEM), .rden(MemReadEn_MEM), .wren(MemWriteEn_MEM), .q(memoryReadData));



MEMWB #(82) memwb(.Q({aluRes_WB, DestReg_WB, memoryReadData_WB, PCPlus1_WB, jal_WB, MemtoReg_WB, RegWriteEn_WB}),
.D({aluRes_MEM, DestReg_MEM, memoryReadData, PCPlus1_MEM, jal_MEM, MemtoReg_MEM, RegWriteEn_MEM}), 
.clk(clk), .reset(rst));


mux2x1 #(32) WBMux(.in1(aluRes_WB), .in2(memoryReadData_WB), .s(MemtoReg_WB), .out(WBMuxOutput));
	
mux2x1 #(32) WritePc(.in1(WBMuxOutput),.in2({22'b0,PCPlus1_WB}),.s(jal_WB),.out(writeData_WB));






endmodule