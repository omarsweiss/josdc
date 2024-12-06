module pipeline(input clk, input rst, output [9:0] PC);




wire [31:0] instruction, writeData_WB, readData1, readData2, extImm, readData1_EX, readData2_EX, memoryReadData_WB, WBMuxOutput, WriteDmem,
extImm_EX, aluRes_EX, forwardBRes_EX, aluRes_MEM, aluRes_WB, forwardBRes_MEM, instruction_ID,memoryReadData;
wire [9:0]  jaddress, adderResult, PCPlus1, PC_ID, PCPlus1_ID, jaddress_ID, adderResult_ID, PCPlus1_EX, PCPlus1_MEM, 
PCPlus1_WB,Branch_state_F, BranchAddress_F, BranchAddress_ID, Branch_state_ID,BranchAddress_EX, Branch_state_EX ;
wire [4:0] shamt, rs, rt, DestReg, shamt_EX, rs_EX, rt_EX,rt_MEM, DestReg_EX, DestReg_MEM, DestReg_WB;
wire [3:0] ALUOp, ALUOp_EX;
wire [1:0] forwardA, forwardB, fwdAbranch, fwdBbranch;
wire taken, jr, RegWriteEn_WB, Branch,Branch_EX, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc, RegDst,jr_EX, bne, bne_EX,
jump, jal,  MemReadEn_EX, MemtoReg_EX, MemWriteEn_EX, RegWriteEn_EX, ALUSrc_EX, jal_EX, ld_hazard, branch_hazard,
MemReadEn_MEM, MemtoReg_MEM, MemWriteEn_MEM, RegWriteEn_MEM, ALUSrc_MEM, jal_MEM, jal_WB, MemtoReg_WB,memFw, prediction_F,
prediction_ID,prediction_EX;


  




fetch fetch(
.clk(clk), .rst(rst),  .reg1Addr(readData1_EX[9:0]), .hold(ld_hazard), .prediction(prediction_F), .prediction_EX(prediction_EX),
.taken(taken), .jr(jr_EX), .PCPlus1(PCPlus1), .PC(PC), .Branch_EX(Branch_EX),
.instruction(instruction),.PCPlus1_EX(PCPlus1_EX),.BranchAddress_EX(BranchAddress_EX),
.Branch_state_F(Branch_state_F), .Branch_state_EX(Branch_state_EX), .BranchAddress_F(BranchAddress_F));


IFID #(63) ifid(.Q({PCPlus1_ID, instruction_ID, BranchAddress_ID, Branch_state_ID, prediction_ID}), 
.D({PCPlus1, instruction, BranchAddress_F, Branch_state_F, prediction_F}), .clk(clk), .reset(rst), .hold(ld_hazard), .flush(branch_hazard));





decode dcd(.clk(clk), .rst(rst), 
.instruction(instruction_ID), .RegWriteEn_WB(RegWriteEn_WB), .writeRegister_WB(DestReg_WB),
.shamt(shamt), .Branch(Branch), .MemReadEn(MemReadEn), .MemtoReg(MemtoReg), .MemWriteEn(MemWriteEn), .RegWriteEn(RegWriteEn), .ALUSrc(ALUSrc),
.jr(jr), .jal(jal), .jal_WB(jal_WB), .writeData_WB(writeData_WB),
.ALUOp(ALUOp), .rs(rs), .rt(rt), .RegDst(RegDst), .bne(bne),
.DestReg(DestReg), .readData1(readData1), .readData2(readData2), .extImm(extImm));



hazard_detection HDU(
  
  .rs_ID(rs), .rt_ID(rt), .dest_EXE(DestReg_EX),
  .mem_read_EX(MemReadEn_EX),.branch(Branch_EX), .branchValid(taken),
  .regDest_ID(RegDst), .jr(jr_EX), .prediction(prediction_EX),
  
  .ld_has_hazard(ld_hazard), .branch_has_hazard(branch_hazard));
  
  
  
IDEX #(160) idex(.Q({shamt_EX, MemReadEn_EX, MemtoReg_EX, MemWriteEn_EX, RegWriteEn_EX, ALUSrc_EX, jal_EX, ALUOp_EX, rs_EX, rt_EX, DestReg_EX, readData1_EX, readData2_EX, extImm_EX, PCPlus1_EX, Branch_EX, bne_EX, jr_EX,BranchAddress_EX, Branch_state_EX, prediction_EX}), 
.D({shamt, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc, jal, ALUOp, rs, rt, DestReg, readData1, readData2, extImm, PCPlus1_ID, Branch, bne, jr, BranchAddress_ID, Branch_state_ID, prediction_ID}), 
.clk(clk), .reset(rst), .flush(ld_hazard | branch_hazard));



execute exec(
    .readData1(readData1_EX), .readData2(readData2_EX), .aluRes_MEM(aluRes_MEM), 
    .aluRes_WB(WBMuxOutput), .extImm(extImm_EX), .ALUOp(ALUOp_EX), .ALUSrc(ALUSrc_EX), 
    .forwardA(forwardA), .forwardB(forwardB), .shamt_EX(shamt_EX), 
    .aluRizz_EX(aluRes_EX), .forwardBRizz_EX(forwardBRes_EX),.taken(taken), .Branch(Branch_EX), .bne(bne_EX));



forwarding_unit fw(
  .rs_ex(rs_EX),
  .rt_ex(rt_EX),
  .rt_mem(rt_MEM),
  .MemWriteEn_MEM(MemWriteEn_MEM),
  .dest_mem(DestReg_MEM),
  .dest_wb(DestReg_WB),
  .rst(rst),
  .regwrite_mem(RegWriteEn_MEM),
  .regwrite_wb(RegWriteEn_WB),
  .memFw(memFw),
  .ForwardA(forwardA),
  .ForwardB(forwardB));



EXMEM #(89) exmem(
    .Q({aluRes_MEM, forwardBRes_MEM, MemReadEn_MEM, MemtoReg_MEM, MemWriteEn_MEM, RegWriteEn_MEM, jal_MEM, DestReg_MEM, PCPlus1_MEM, rt_MEM}), 
    .D({aluRes_EX, forwardBRes_EX, MemReadEn_EX, MemtoReg_EX, MemWriteEn_EX, RegWriteEn_EX,  jal_EX, DestReg_EX, PCPlus1_EX,rt_EX}), 
    .clk(clk), .reset(rst)
);



mux2x1 #(32) memForward(.in1(forwardBRes_MEM), .in2(WBMuxOutput), .s(memFw), .out(WriteDmem) );
dataMemory DM(.address(aluRes_MEM[7:0]), .clock(~clk), .data(WriteDmem), .rden(MemReadEn_MEM), .wren(MemWriteEn_MEM), .q(memoryReadData));



MEMWB #(82) memwb(.Q({aluRes_WB, DestReg_WB, memoryReadData_WB, PCPlus1_WB, jal_WB, MemtoReg_WB, RegWriteEn_WB}),
.D({aluRes_MEM, DestReg_MEM, memoryReadData, PCPlus1_MEM, jal_MEM, MemtoReg_MEM, RegWriteEn_MEM}), 
.clk(clk), .reset(rst));


mux2x1 #(32) WBMux(.in1(aluRes_WB), .in2(memoryReadData_WB), .s(MemtoReg_WB), .out(WBMuxOutput));
	
mux2x1 #(32) WritePc(.in1(WBMuxOutput),.in2({22'b0,PCPlus1_WB}),.s(jal_WB),.out(writeData_WB));






endmodule