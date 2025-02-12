module processor(input clk,input rst, output [9:0] PC, output [31:0] out);

wire stall,arithmetic1,arithmetic2, alu_src,alu_src2,RegWrite1,RegWrite2,rs1_ready,rt1_ready,rs2_ready,rt2_ready,rob_full,
rs1_rob,rt1_rob,rs2_rob,rt2_rob,alu1_wr,alu2_wr,full_RSA,zero1,zero2,commit1,commit2;
wire [9:0] pc_in,jaddress;
wire [8:0] control_out1,control_out2;
wire [3:0] alu_op,alu_op2;
wire [4:0] rs1,rt1,rd1, shamt,rs2,rt2,rd2, shamt2,dest_reg,dest_reg2,rs1_tag,rt1_tag,rs2_tag,rt2_tag,dest1_tag,dest2_tag,tag,
arith_dest1_out,arith_dest2_out,arith_tag1,arith_tag2,commit_addr1,commit_addr2,commit_p;
wire [5:0] opCode, funct,opCode2, funct2;
wire [15:0] imm,imm2,immediate,immediate2;
wire [31:0] first_instr_im, second_instr_im,readData1_1,readData2_1,readData1_2,readData2_2,rs_data_rob1,rt_data_rob1,rs_data_rob2,rt_data_rob2,
RS_val1_1,RS_val2_1,RS_val1_2,RS_val2_2,val1_1_out,val2_1_out,val1_2_out,val2_2_out,alu2_result,alu1_result,commit_data1,commit_data2;


reg [31:0] first_instr, second_instr,alu1_res_pipe,alu2_res_pipe, rs1_frwd_data,rt1_frwd_data,rs2_frwd_data, rt2_frwd_data;
reg alu1_wr_pipe,alu2_wr_pipe,rs1_frwd,rt1_frwd,rs2_frwd,rt2_frwd;
reg [4:0] arith_dest1_pipe,arith_dest2_pipe,arith_tag1_pipe,arith_tag2_pipe;


assign pc_in = PC + 10'd2;
assign stall = rob_full | full_RSA;

assign out = commit_data1;

programCounter pc(.clk(clk), .rst(rst), .PCin(pc_in), .PCout(PC), .hold(0));


instructionMemory IM(.address_a(PC),.address_b(PC + 10'b1),.clock(clk),.q_a(first_instr_im),.q_b(second_instr_im));

always @(posedge clk, negedge rst) begin

	if(~rst)begin
		first_instr <= 0;
		second_instr <= 0;
	end
	else if (~stall) begin
		first_instr <= first_instr_im;
		second_instr <= second_instr_im;
	end
	
end


assign opCode = first_instr[31:26];
assign rs1 = first_instr[25:21];
assign rt1 = first_instr[20:16];
assign rd1 = first_instr[15:11];
assign imm = first_instr[15:0];
assign funct = first_instr[5:0];
assign shamt = first_instr[10:6];
assign jaddress = first_instr[9:0];

assign opCode2 = second_instr[31:26];
assign rs2 = second_instr[25:21];
assign rt2 = second_instr[20:16];
assign rd2 = second_instr[15:11];
assign imm2 = second_instr[15:0];
assign funct2 = second_instr[5:0];
assign shamt2 = second_instr[10:6];
assign jaddress2 = second_instr[9:0];



controlUnit CU1(.opCode(opCode), .funct(funct), .RegDst(), .Branch(), .MemReadEn(), .MemtoReg(),.ALUOp(alu_op), .MemWriteEn(),
				.RegWriteEn(RegWrite1), .ALUSrc(alu_src),.bne(),.jump(),.jal(),.jr(),.arithmetic(arithmetic1));

controlUnit CU2(.opCode(opCode2), .funct(funct2), .RegDst(), .Branch(), .MemReadEn(), .MemtoReg(),.ALUOp(alu_op2), .MemWriteEn(),
				.RegWriteEn(RegWrite2), .ALUSrc(alu_src2),.bne(),.jump(),.jal(),.jr(),.arithmetic(arithmetic2));


				
assign dest_reg = alu_src? rt1:rd1;
assign dest_reg2 = alu_src2? rt2:rd2;



SignExtender se1(imm, immediate);
SignExtender se2(imm2, immediate2);



registerFile rf(.clk(clk), .rst(rst), .we(commit1), .we2(commit2), 
					 .readRegister1_1(rs1), .readRegister2_1(rt1),.readRegister1_2(rs2), .readRegister2_2(rt2),  .writeRegister(commit_addr1), .writeRegister2(commit_addr2),
					 .writeData(commit_data1), .writeData2(commit_data2), .readData1_1(readData1_1), .readData2_1(readData2_1), .readData1_2(readData1_2), .readData2_2(readData2_2));


RAT rat( .clk(clk), .rst(rst),
.stall(stall), .RegWrite1(RegWrite1), .RegWrite2(RegWrite2), .commit1(commit1), .commit2(commit2), .alu1_wr(alu1_wr_pipe), .alu2_wr(alu2_wr_pipe), .ld1_wr(0), .ld2_wr(0),
.alu1_res_tag(arith_tag1_pipe), .alu2_res_tag(arith_tag2_pipe), .ld1_res_tag(0), .ld2_res_tag(0), .alu1_dest(arith_dest1_pipe), .alu2_dest(arith_dest2_pipe), .ld1_dest(0), .ld2_dest(0), .commit1_addr(commit_addr1),
.commit2_addr(commit_addr2), .rs1(rs1), .rt1(rt1), .rs2(rs2), .rt2(rt2), .tag1(tag), .tag2(tag + 5'b1), .DestReg1(dest_reg), .DestReg2(dest_reg2), .commit1_tag(commit_p), .commit2_tag(commit_p + 5'b1),

.rs1_ready(rs1_ready), .rt1_ready(rt1_ready), .rs2_ready(rs2_ready), .rt2_ready(rt2_ready),
.rs1_rob(rs1_rob), .rt1_rob(rt1_rob), .rs2_rob(rs2_rob), .rt2_rob(rt2_rob),
.rs1_tag(rs1_tag), .rt1_tag(rt1_tag), .rs2_tag(rs2_tag), .rt2_tag(rt2_tag), .dest1_tag(dest1_tag), .dest2_tag(dest2_tag)

);




ROB rob(

.clk(clk), .rst(rst), .stall(stall), .alu_res_en(alu1_wr_pipe), .alu_res_en2(alu2_wr_pipe), .ld_r(0), .ld_r2(0), .sw_r(0), .sw_r2(0), 
.branch_r(0), .prediction(0), .branch_result(0), .nop(0), .one_instr(0),
.alu_dest(arith_dest1_pipe), .alu_dest2(arith_dest2_pipe), .ld_dest(0),.ld_dest2(0), .sw_tag(0), .sw_tag2(0), .branch_tag(0), .alu_tag(arith_tag1_pipe), .alu_tag2(arith_tag2_pipe),
.ld_tag(0),.ld_tag2(0), .ghr_BR(0), .read_tag1(rs1_tag), .read_tag2(rt1_tag), .read_tag1_2(rs2_tag), .read_tag2_2(rt2_tag),
.next_addr_BR(0), .b_addr_BR(0), .alu_val(alu1_res_pipe) , .alu_val2(alu2_res_pipe), .ld_val(0) , .ld_val2(0),

.commit(commit1), .commit2(commit2), .commit_sw(), .commit_sw2(), .update_signal_C1(), .update_signal_C2(), .prediction_C1(),
.prediction_C2(), .actual_outcome_C1(), .actual_outcome_C2(),
.commit_addr(commit_addr1), .commit_addr2(commit_addr2), .ghr_C1(), .ghr_C2(),
.next_addr_C1(), .next_addr_C2(),
.b_addr_C1(), .b_addr_C2(),
.commit_data(commit_data1), .commit_data2(commit_data2),
.read_rob1(rs_data_rob1), .read_rob2(rt_data_rob1), .read_rob1_2(rs_data_rob2), .read_rob2_2(rt_data_rob2),
.commit_p(commit_p), .disp_p(tag), .full(rob_full)
);



/////////////////////////////////////////////////////////////////////////////////////////////////


assign RS_val1_1 = rs1_ready ? readData1_1 : rs_data_rob1;
assign RS_val2_1 = rt1_ready ? readData2_1 : rt_data_rob1;

assign RS_val1_2 = rs2_ready ? readData1_2 : rs_data_rob2;
assign RS_val2_2 = rt2_ready ? readData2_2 : rt_data_rob2;


// forwarding

always@(*) begin

		if (alu1_wr_pipe & (arith_tag1_pipe == rs1_tag)) begin
			rs1_frwd = 1'b1;
			rs1_frwd_data = alu1_res_pipe;
		end
		else if (alu2_wr_pipe & (arith_tag2_pipe == rs1_tag)) begin
			rs1_frwd = 1'b1;
			rs1_frwd_data = alu2_res_pipe;
		end
		else begin
			rs1_frwd = 1'b0;
			rs1_frwd_data = 32'bx;
		end
		
		////////////////////////////////////////////////////////////////////////
		if (alu1_wr_pipe & (arith_tag1_pipe == rt1_tag)) begin
			rt1_frwd = 1'b1;
			rt1_frwd_data = alu1_res_pipe;
		end
		else if (alu2_wr_pipe & (arith_tag2_pipe == rt1_tag)) begin
			rt1_frwd = 1'b1;
			rt1_frwd_data = alu2_res_pipe;
		end
		else begin
			rt1_frwd = 1'b0;
			rt1_frwd_data = 32'bx;
		end
		
		////////////////////////////////////////////////////////////////////////
		if (alu1_wr_pipe & (arith_tag1_pipe == rs2_tag)) begin
			rs2_frwd = 1'b1;
			rs2_frwd_data = alu1_res_pipe;
		end
		else if (alu2_wr_pipe & (arith_tag2_pipe == rs2_tag)) begin
			rs2_frwd = 1'b1;
			rs2_frwd_data = alu2_res_pipe;
		end
		else begin
			rs2_frwd = 1'b0;
			rs2_frwd_data = 32'bx;
		end
		
		////////////////////////////////////////////////////////////////////////
		if (alu1_wr_pipe & (arith_tag1_pipe == rt2_tag)) begin
			rt2_frwd = 1'b1;
			rt2_frwd_data = alu1_res_pipe;
		end
		else if (alu2_wr_pipe & (arith_tag2_pipe == rt2_tag)) begin
			rt2_frwd = 1'b1;
			rt2_frwd_data = alu2_res_pipe;
		end
		else begin
			rt2_frwd = 1'b0;
			rt2_frwd_data = 32'bx;
		end
end


/////////////////////////////////////////////
ReservationStation_Arithmetic RS_arith(
    .clk(clk), .rst(rst),  .stall(stall), .arithmetic1(arithmetic1),  .arithmetic2(arithmetic2),
    .ready_rs1(rs1_ready | rs1_rob | rs1_frwd), .ready_rt1(rt1_ready | rt1_rob | rt1_frwd), .ready_rs2(rs2_ready | rs2_rob |rs2_frwd), .ready_rt2(rt2_ready| rt2_rob |rt2_frwd), 
    .rs1_tag(rs1_tag), .rt1_tag(rt1_tag), .rs2_tag(rs2_tag), .rt2_tag(rt2_tag), .dest1_tag(dest1_tag), .dest2_tag(dest2_tag), .dest1(dest_reg), .dest2(dest_reg2), 
    .control1({alu_op,shamt}), .control2({alu_op2,shamt2}), 
    .val1_1(rs1_frwd? rs1_frwd_data: RS_val1_1), .val2_1(rt1_frwd? rt1_frwd_data: RS_val2_1), .val1_2(rs2_frwd? rs2_frwd_data: RS_val1_2), .val2_2(rt2_frwd? rt2_frwd_data: RS_val2_2),
	 
    .alu1_wr(alu1_wr_pipe), .alu2_wr(alu2_wr_pipe), .ld1_wr(0), .ld2_wr(0),
    .alu1_res_tag(arith_tag1_pipe), .alu2_res_tag(arith_tag2_pipe), .ld1_res_tag(0), .ld2_res_tag(0),
    .alu1_res(alu1_res_pipe), .alu2_res(alu2_res_pipe), .ld1_res(0), .ld2_res(0),
    
    
    .write1(alu1_wr), .write2(alu2_wr),
    .dest1_out(arith_dest1_out), .dest2_out(arith_dest2_out), .dest1_tag_out(arith_tag1), .dest2_tag_out(arith_tag2), 
    .control_out1(control_out1), .control_out2(control_out2),
    .val1_1_out(val1_1_out), .val2_1_out(val2_1_out), .val1_2_out(val1_2_out), .val2_2_out(val2_2_out),

    .full_RSA(full_RSA)
);

ALU alu1(
    .operand1 ( val1_1_out ),
    .operand2 ( val2_1_out ),
    .opSel    ( control_out1[8:5]),
    .result   ( alu1_result),
    .zero     ( zero1),
    .shamt    ( control_out1[4:0])
);

ALU alu2(
    .operand1 ( val1_2_out ),
    .operand2 ( val2_2_out ),
    .opSel    ( control_out2[8:5]),
    .result   ( alu2_result),
    .zero     ( zero2),
    .shamt    ( control_out2[4:0])
);


always @(posedge clk, negedge rst) begin
	if(~rst) begin
		alu1_res_pipe <= 0;
		alu2_res_pipe <= 0;
		alu1_wr_pipe <= 0;
		alu2_wr_pipe <= 0;
		arith_dest1_pipe <= 0;
		arith_dest2_pipe <= 0;
		arith_tag1_pipe <= 0;
		arith_tag2_pipe <= 0;
	end
	else begin
		alu1_res_pipe <= alu1_result;
		alu2_res_pipe <= alu2_result;
		alu1_wr_pipe <= alu1_wr;
		alu2_wr_pipe <= alu2_wr;
		arith_dest1_pipe <= arith_dest1_out;
		arith_dest2_pipe <= arith_dest2_out;
		arith_tag1_pipe <= arith_tag1;
		arith_tag2_pipe <= arith_tag2;
	end

end




endmodule