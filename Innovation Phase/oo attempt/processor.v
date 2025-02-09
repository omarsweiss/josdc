module processor(input clk, input rst, output [9:0] PC);

wire rs_full, iq_full, write_on_rs_rob, iq_empty, Branch, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, 
ALUSrc, jr_cu, jal,arithmetic, regdst, bne, write_on_rs_idiss, write_rob, hold_iq,
rob_full, write_rf, write_rat, ALUSrc_idiss, allocated_rs, allocated_rt,jr_out, 
write_rob2, jump, zero, zero2, commit1, commit2,SW_en,SW_en2,LS_disp,LS_disp2,buff_sw,buff_sw2,
LS_RS_full,SW_buff_full,buff_ld,buff_ld2,alu_wr,alu_wr2,commit_sw,commit_sw2,ld_found,ld_found2;
wire [3:0] ALUOp, ALUOp_idiss;
wire [4:0] rd, rt,rs,  writeRegister, regAddress, DestReg, DestReg_idiss, rs_idiss, rt_idiss, val_idx, rob_tag, commit_addr, commit_addr2, wb_entry, wb_entry2, rs_rat, rt_rat,
shamt, shamt_idiss, dest_out, dest_out2,L_dest,L_dest2,sw_tag_disp,sw_tag_disp2;
wire [5:0] opCode, funct;
wire [9:0] PCplus,jal_address,jr_addr,jr_final_addr;
wire [8:0] control_out1, control_out2;
wire [15:0] imm;
wire [31:0] instruction, iq_instruction, wb_value, commit_val, commit_val2, imm_ext, imm_ext_idiss, data1, data2, alu_res, alu_res2, val2,
op1, op2, op1_2, op2_2,LS_addr,LS_addr2,S_data,S_data2,buff_addr,buff_addr2,buff_data,buff_data2,Dmem_addr,Dmem_addr2,Dmem_res,Dmem_res2,ld_res,ld_res2;



reg [4:0] ld_dest,ld_dest2;

assign out = commit_val;
/////////////////Fetch from IM////////////


fetch Fetch( .clk(clk),.rst(rst),.PC(PC),.jr_in((jr_cu && ~allocated_rs) || jr_out),.jr_address(jr_final_addr),.instruction(instruction),
				.jump(jump),.hold(hold_iq));


InstructionQueue IQ(
    .clk(clk),             // Clock signal
    .reset(rst),           // Reset signal
    .enqueue(~jump && ~hold_iq),         // Signal to enqueue an instruction
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
assign jal_address = iq_instruction[9:0];



controlUnit cu(.opCode(iq_instruction[31:26]), .funct(iq_instruction[5:0]),
				   .RegDst(regdst), .Branch(Branch), .MemReadEn(MemReadEn), .MemtoReg(MemtoReg),
				   .ALUOp(ALUOp), .MemWriteEn(MemWriteEn), .RegWriteEn(RegWriteEn), .ALUSrc(ALUSrc),.bne(bne),.jump(),.jal(jal),.jr(jr_cu),.arithmetic(arithmetic));


mux2x1 #(5) immMux(.in1(rt), .in2(rd), .s(regdst), .out(DestReg));

SignExtender se(.in(imm), .out(imm_ext));


ROB rob(
.clk(clk),
.rst(rst),
.issue(write_on_rs_rob),
.write(alu_wr),
.write2(alu_wr2),
.sw_disp(SW_en),
.sw_disp2(SW_en2),
.ld_write(buff_ld),
.ld_write2(buff_ld2),
.SW_in(MemWriteEn),
.jal(jal),
.dest_reg(DestReg),
.sw_disp_tag(sw_tag_disp),
.sw_disp_tag2(sw_tag_disp2),
.val_idx(dest_out),
.val_idx2(dest_out2),
.ld_dest(ld_dest),
.ld_dest2(ld_dest2),
.jal_address(jal_address),
.value(alu_res),
.value2(alu_res2),
.ld_value(ld_res),
.ld_value2(ld_res2),
.tag(rob_tag),
.commit_addr(commit_addr),
.commit_addr2(commit_addr2),
.commit_val(commit_val),
.commit_val2(commit_val2),
.full(rob_full),
.commit1(commit1),
.commit2(commit2), //Set when commiting to write on the RF
.write_rat(write_rat),
.commit_SW(commit_sw),
.commit_SW2(commit_sw2)
);



RAT rat(
.clk(~clk),
.rst(rst),
.write(write_rat && RegWriteEn), 
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


jr_rs JR_reg(
 .clk(clk), .rst(rst), .jr_in(jr_cu), .alloc(allocated_rs),
.tag_jr(rs_rat), .alu_res_tag(dest_out), .alu_res_tag2(dest_out2), .ld_dest(ld_dest),.ld_dest2(ld_dest2),
.value(alu_res), .value2(alu_res2), .ld_value(ld_res), .ld_value2(ld_res2), .jr_out(jr_out),.jr_addr(jr_addr));

mux2x1 #(10) jr_address(.in1(data1[9:0]), .in2(jr_addr), .s(jr_out), .out(jr_final_addr));

					 
/////////Mux for the imm value/////////////
mux2x1 #(32) immVal(.in1(data2), .in2(imm_ext), .s(ALUSrc), .out(val2));

reservation_station  rs_arithmetic(
.clk(clk), 
.rst(rst), 
.val1_r(~allocated_rs), 
.val2_r(~allocated_rt || ALUSrc ), 
.write(write_on_rs_rob && arithmetic),
.alu_w_r(alu_wr),
.alu_w_r2(alu_wr2),
.ld_write(buff_ld),
.ld_write2(buff_ld2),
.rs_tag(rs_rat),
.rt_tag(rt_rat),
.dest_tag(rob_tag),
.alu_res_tag(dest_out),
.alu_res_tag2(dest_out2),
.ld_tag(ld_dest),
.ld_tag2(ld_dest2),
.control({ALUOp, shamt}), 
.val1(data1),
.val2(val2),
.alu_res(alu_res),
.alu_res2(alu_res2),
.ld_value(ld_res),
.ld_value2(ld_res2),
.op1(op1),
.op2(op2),
.op1_2(op1_2),
.op2_2(op2_2), 
.dest_out(dest_out),
.dest_out2(dest_out2),
.control_out1(control_out1),
.control_out2(control_out2),
.full(rs_full),
.write_rob(alu_wr),
.write_rob2(alu_wr2)
);



/////////////////memory//////////////////

reservation_station_LS RS_LS(
.clk(clk), 
.rst(rst), 
.data_r(~allocated_rt),
.sw_tag_in(rob_tag),
.reg_r(~allocated_rs), 
.write(write_on_rs_rob && (MemWriteEn || MemReadEn)&& ~SW_buff_full), 
.mem_write(MemWriteEn), 
.commit_sw1(commit_sw), 
.commit_sw2(commit_sw2),
.alu_w_r(alu_wr),
.alu_w_r2(alu_wr2),
.ld_write(buff_ld),
.ld_write2(buff_ld2),
.rs_tag(rs_rat), 
.rt_tag(rt_rat), 
.alu_res_tag(dest_out), 
.alu_res_tag2(dest_out2), 
.ld_tag(ld_dest),
.ld_tag2(ld_dest2),
.val1(data1), 
.val2(data2),
.imm(imm_ext), 
.alu_res(alu_res), 
.alu_res2(alu_res2), 
.ld_res(ld_res),
.ld_res2(ld_res2),
.address_out(LS_addr), 
.data_out(S_data), 
.address_out2(LS_addr2), 
.data_out2(S_data2),
.dest_out(L_dest), 
.dest_out2(L_dest2),
.sw_tag_out(sw_tag_disp),
.sw_tag_out2(sw_tag_disp2),
.mem_write_out(SW_en),
.mem_write_out2(SW_en2), 
.disp1(LS_disp), 
.disp2(LS_disp2),
.full(LS_RS_full)
);

store_buffer SW_buffer(
.clk(clk),
.rst(rst), 
.disp1(LS_disp), 
.disp2(LS_disp2), 
.sw_in1(SW_en),
.sw_in2(SW_en2), 
.commit(commit_sw), 
.commit2(commit_sw2),
.address_in(LS_addr),
.data_in(S_data),
.address_in2(LS_addr2), 
.data_in2(S_data2),
.full(SW_buff_full),
.sw_out(buff_sw),
.sw_out2(buff_sw2),
.ld_out(buff_ld),
.ld_out2(buff_ld2), 
.ld_found2(ld_found2), 
.ld_found(ld_found),
.address_out(buff_addr),
.data_out(buff_data),
.address_out2(buff_addr2), 
.data_out2(buff_data2)
);

always @(posedge clk) begin //register to hold reg_dest values
	if(~rst) begin
	ld_dest <= 0;
	ld_dest2 <= 0;
	end else begin
	ld_dest <= L_dest;
	ld_dest2 <= L_dest2;
	end
end

mux2x1 #(32) Dmem_address(.in1(LS_addr), .in2(buff_addr2), .s(buff_sw2), .out(Dmem_addr));
mux2x1 #(32) Dmem_address2(.in1(LS_addr2), .in2(buff_addr), .s(buff_sw), .out(Dmem_addr2));


double_dataMemory DM(
	.address_a(Dmem_addr),
	.address_b(Dmem_addr2),
	.clock(clk),
	.data_a(buff_data2),
	.data_b(buff_data),
	.wren_a(buff_sw2),
	.wren_b(buff_sw),
	.q_a(Dmem_res),
	.q_b(Dmem_res2));

mux2x1 #(32) Dmem_result(.in1(Dmem_res), .in2(buff_data), .s(ld_found), .out(ld_res));
mux2x1 #(32) Dmem_result2(.in1(Dmem_res2), .in2(buff_data2), .s(ld_found2), .out(ld_res2));

//////////////to the ALUs////////////////

ALU alu1(.operand1(op1), .operand2(op2), .opSel(control_out1[8:5]), .result(alu_res), .zero(zero),.shamt(control_out1[4:0]));
ALU alu2(.operand1(op1_2), .operand2(op2_2), .opSel(control_out2[8:5]), .result(alu_res2), .zero(zero2),.shamt(control_out2[4:0]));














endmodule 