module processor(input clk, input rst, output [9:0] PC);

wire rs_full, iq_full, write_on_rs_rob, iq_empty, Branch, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc, jr, jal, regdst, bne, write_on_rs_idiss, write_rob,
rob_full, write_rf, write_rat, ALUSrc_idiss, allocated_rs, allocated_rt, write_rob2, jump, zero, zero2, commit1, commit2;
wire [3:0] ALUOp, ALUOp_idiss;
wire [4:0] rd, rt,rs,  writeRegister, regAddress, DestReg, DestReg_idiss, rs_idiss, rt_idiss, val_idx, rob_tag, commit_addr, commit_addr2, wb_entry, wb_entry2, rs_rat, rt_rat,
shamt, shamt_idiss, dest_out, dest_out2;
wire [5:0] opCode, funct;
wire [9:0] PCplus;
wire [8:0] control_out1, control_out2;
wire [15:0] imm;
wire [31:0] instruction, iq_instruction, wb_value, commit_val, commit_val2, imm_ext, imm_ext_idiss, data1, data2, alu_res, alu_res2, val2,
op1, op2, op1_2, op2_2;


/////////////////Fetch from IM////////////


adder PCAdder(.in1(PC), .in2(10'd1), .out(PCplus));
programCounter pc(clk, rst, 1'b0, PCplus, PC);
instructionMemory IM(.address(PC), .clock(~clk), .q(instruction));
assign whateverthefuck = commit_val;

InstructionQueue IQ(
    .clk(clk),             // Clock signal
    .reset(rst),           // Reset signal
    .enqueue(1'b1),         // Signal to enqueue an instruction
    .instr_in(instruction), // Incoming instruction
    .stall(rs_full),           // Stall signal from RS (prevents issuing)
    .instr_out(iq_instruction), // Instruction to issue
    .full(iq_full),             // Queue full flag
    .write(write_on_rs_rob),				//Flag to enable writing on the RS
	 .empty(iq_empty)             // Queue empty flag
);
/////////////decode starts///////////////
assign rs = iq_instruction[25:21];
assign rt = iq_instruction[20:16];
assign rd = iq_instruction[15:11];
assign imm = iq_instruction[15:0];
assign shamt = iq_instruction[10:6];



controlUnit cu(.opCode(iq_instruction[31:26]), .funct(iq_instruction[5:0]),
				   .RegDst(regdst), .Branch(Branch), .MemReadEn(MemReadEn), .MemtoReg(MemtoReg),
				   .ALUOp(ALUOp), .MemWriteEn(MemWriteEn), .RegWriteEn(RegWriteEn), .ALUSrc(ALUSrc),.bne(bne),.jump(jump),.jal(jal),.jr(jr));


mux2x1 #(5) immMux(.in1(rt), .in2(rd), .s(regdst), .out(DestReg));

SignExtender se(.in(imm), .out(imm_ext));

//Added a pipeline here to seperate the CU from the renaming stage. Can be removed if found inconvenient.
/*IDISS #(58) idiss(
.Q({DestReg_idiss, rs_idiss, rt_idiss, imm_ext_idiss, ALUOp_idiss, write_on_rs_idiss, ALUSrc_idiss, shamt_idiss}), 
.D({DestReg, rs, rt, imm_ext, ALUOp, write_on_rs, ALUSrc, shamt}), 
.clk(clk), .reset(rst), .flush(1'b0));
*/
////////////renaming starts////////////////
ROB rob(
.clk(clk),
.rst(rst),
.issue(write_on_rs_rob),
.write(write_rob),
.write2(write_rob2),
.dest_reg(DestReg), 
.val_idx(dest_out),
.val_idx2(dest_out2),
.value(alu_res),
.value2(alu_res2),
.tag(rob_tag),
.commit_addr(commit_addr),
.commit_addr2(commit_addr2),
.commit_val(commit_val),
.commit_val2(commit_val2),
.full(rob_full),
.commit1(commit1),
.commit2(commit2), //Set when commiting to write on the RF
.write_rat(write_rat)
);


RAT rat(
.clk(~clk),
.rst(rst),
.write(write_rat), 
.free(commit1), //The free flag is the same for the write flag in the rob. 
.free2(commit2),
.dest_in(DestReg), 
.tag_in(rob_tag),
.rs_in(rs),
.rt_in(rt),
.tag_done(commit_addr),
.tag_done2(commit_addr2),
.rs_out(rs_rat),
.rt_out(rt_rat), 
.allocated_rs(allocated_rs),
.allocated_rt(allocated_rt)
);

registerFile rf(.clk(clk), .rst(rst), .we(commit1), .we2(commit2), 
.readRegister1(rs), .readRegister2(rt), .writeRegister(commit_addr), .writeRegister2(commit_addr2),
.writeData(commit_val), .writeData2(commit_val2), .readData1(data1), .readData2(data2));
					 
/////////Mux for the imm value/////////////
mux2x1 #(32) immVal(.in1(data2), .in2(imm_ext), .s(ALUSrc), .out(val2));

reservation_station  rsarithmetic(
.clk(clk), 
.rst(rst), 
.val1_r(~allocated_rs), 
.val2_r(~allocated_rt || ALUSrc ), 
.write(write_on_rs_rob),
.rs_tag(rs_rat),
.rt_tag(rt_rat),
.dest_tag(rob_tag),
.alu_res_tag(dest_out),
.alu_res_tag2(dest_out2),
.control({ALUOp, shamt}), 
.val1(data1),
.val2(val2),
.alu_res(alu_res),
.alu_res2(alu_res2),
.op1(op1),
.op2(op2),
.op1_2(op1_2),
.op2_2(op2_2), 
.dest_out(dest_out),
.dest_out2(dest_out2),
.control_out1(control_out1),
.control_out2(control_out2),
.full(rs_full),
.write_rob(write_rob),
.write_rob2(write_rob2)
);


//////////////to the ALUs////////////////

ALU alu1(.operand1(op1), .operand2(op2), .opSel(control_out1[8:5]), .result(alu_res), .zero(zero),.shamt(control_out1[4:0]));
ALU alu2(.operand1(op1_2), .operand2(op2_2), .opSel(control_out2[8:5]), .result(alu_res2), .zero(zero2),.shamt(control_out2[4:0]));














endmodule 