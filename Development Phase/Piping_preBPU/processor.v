module processor(clk, rst, PC);

	//inputs
	input clk, rst;
	output [9:0] PC;
	//nextpc,pcplus1,pc,adderres take 10 bits from sign extended value for branch adder
	//outputs
	wire [9:0]nextPC, PCPlus1, adderResult,branchAddress,jaddress,JrAddress,PC; // changed from 6 bits to 10 bits bc 1kb memory
	
	wire [31:0] instruction, writeData, readData1, readData2, extImm, ALUin2, ALUResult, memoryReadData,WBMuxOutput;
	wire [15:0] imm;
	wire [5:0] opCode, funct;
	wire [4:0] rs, rt, rd, writeRegister,shamt,regAddress;
	wire [3:0] ALUOp;//change from 3 to 4
	wire RegDst, Branch, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc, zero, PCsrc,bne,jump,jal,jr;//added bne control signal, added jump signal
	
	assign opCode = instruction[31:26];
	assign rs = instruction[25:21];// rs,rt,rd were assigned to the wrong bits in the opcode, fixed.
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	assign imm = instruction[15:0];
	assign funct = instruction[5:0];
	assign shamt = instruction[10:6];//added shamt
	assign jaddress = instruction[9:0];//added jump address
	
	programCounter pc(.clk(clk), .rst(rst), .PCin(nextPC), .PCout(PC)); // talk abt pc in free space
	
	adder PCAdder(.in1(PC), .in2(10'b1), .out(PCPlus1));	
	
	instructionMemory IM(.address(nextPC), .clock(clk), .q(instruction));
	//retardmemory IM(.address(nextPC), .clk(clk), .instruction(instruction));
	
	controlUnit CU(.opCode(opCode), .funct(funct), 
				      .RegDst(RegDst), .Branch(Branch), .MemReadEn(MemReadEn), .MemtoReg(MemtoReg),
				      .ALUOp(ALUOp), .MemWriteEn(MemWriteEn), .RegWriteEn(RegWriteEn), .ALUSrc(ALUSrc),.bne(bne),.jump(jump),.jal(jal),.jr(jr));
	
	mux2x1 #(5) RFMux(.in1(rt), .in2(rd), .s(RegDst), .out(writeRegister));//writeRegister was named WriteRegister, fixed.
	
	mux2x1 #(5) RegWriteMux(.in1(writeRegister),.in2(5'd31),.s(jal),.out(regAddress)); //added to implement jal
	
	registerFile RF(.clk(clk), .rst(rst), .we(RegWriteEn), 
					    .readRegister1(rs), .readRegister2(rt), .writeRegister(regAddress),
					    .writeData(writeData), .readData1(readData1), .readData2(readData2));
						 
	SignExtender SignExtend(.in(imm), .out(extImm));//module name SignExtender->signextender
	
	mux2x1 #(32) ALUMux(.in1(readData2), .in2(extImm), .s(ALUSrc), .out(ALUin2)); //
	
	ALU alu(.operand1(readData1), .operand2(ALUin2), .opSel(ALUOp), .result(ALUResult), .zero(zero), .shamt(shamt));//added shamt
	
	//ANDGate branchAnd(.in1(zero), .in2(Branch), .out(PCsrc));
	
	assign PCsrc = Branch & (bne ^ zero); //Added a different circuit for the PCsrc to account for the bneq instruction.
	
	adder branchAdder(.in1(PCPlus1), .in2(imm[9:0]), .out(adderResult));
	
	dataMemory DM(.address(ALUResult[7:0]), .clock(~clk), .data(readData2), .rden(MemReadEn), .wren(MemWriteEn), .q(memoryReadData)); 
	
	mux2x1 #(32) WBMux(.in1(ALUResult), .in2(memoryReadData), .s(MemtoReg), .out(WBMuxOutput));//mux inputs were reversed here, fixed,WriteData changed to WBMuxOutput to implement jal
	
   mux2x1 #(32) WritePc(.in1(WBMuxOutput),.in2({22'b0,PCPlus1}),.s(jal),.out(writeData));
	
	mux2x1 #(10) PCMux(.in1(PCPlus1), .in2(adderResult), .s(PCsrc), .out(branchAddress));//0 gives in1 1 gives in2, changed name from nextPC to branchaddress for jump implementation
	
	mux2x1 #(10) JRMux(.in1(jaddress),.in2(readData1[9:0]),.s(jr),.out(JrAddress));
	
	mux2x1 #(10) jumpMux(.in1(branchAddress),.in2(JrAddress),.s(jump),.out(nextPC));
	
	
	
endmodule
