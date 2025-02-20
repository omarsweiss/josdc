module t_pipe(input clk,input rst,
input flush_IFID, flush_IDEX, correct_en,jal1_WB,jal2_WB,regWrite1_WB,regWrite2_WB, jr1_in, jr2_in,

input [4:0] ForwardA_1,ForwardB_1,ForwardA_2,ForwardB_2,

input [4:0] writeReg1_WB,writeReg2_WB,
 
input [9:0] correction,jr_addr1_in,jr_addr2_in,

input [31:0]writeData1_WB,writeData2_WB, aluRes1_WB,aluRes2_WB,aluRes1_MEM_fwd,aluRes2_MEM_fwd,

output Branch1,Branch2, taken1, taken2, taken1_MEM,  MemReadEn1_MEM, MemtoReg1_MEM, MemWriteEn1_MEM, RegWriteEn1_MEM,jal1_MEM,
 taken2_MEM,  MemReadEn2_MEM, MemtoReg2_MEM, MemWriteEn2_MEM, RegWriteEn2_MEM,jal2_MEM, Branch1_MEM,Branch2_MEM, Branch2_EX, Branch1_EX,RegWriteEn1_EX,RegWriteEn2_EX,
 jr1_out,jr2_out,

output [4:0]  DestReg1_MEM, rt1_MEM, DestReg2_MEM, rt2_MEM,rs1,rt1,rs2,rt2,destReg1,destReg2, DestReg1_EX, DestReg2_EX,

output [9:0] return_addr2_ID, return_addr2_EX, return_addr1_MEM, return_addr2_MEM,BranchAddress1_EX, BranchAddress2_EX,next_pc_out,
jr_addr1_out, jr_addr2_out,

output [31:0] aluRes1_MEM, forwardBRes1_MEM, aluRes2_MEM, forwardBRes2_MEM
      
);

wire [31:0] instruction_1,instruction_2,readData1_1,readData2_1,readData1_2,readData2_2,extImm1,
extImm2,readData1_1_EX, readData2_1_EX, extImm1_EX,readData1_2_EX, readData2_2_EX, extImm2_EX,
ForwardB1_EX,ForwardB2_EX,aluRes1,aluRes2,instruction1_ID,instruction2_ID;

wire [9:0] return_addr1,return_addr2,reg1Addr,BranchAddress_1,BranchAddress_2,return_addr1_ID,
BranchAddress1_ID,BranchAddress2_ID,return_addr1_EX;

wire [4:0] shamt1,shamt2, shamt1_EX,shamt2_EX,rs2_EX, rt2_EX,rs1_EX, rt1_EX;

wire [3:0] AluOp1,AluOp2,ALUOp1_EX,ALUOp2_EX;


wire  ld_hazard,jr_hazard, flush_second, MemReadEn1, MemtoReg1, MemWriteEn1, RegWriteEn1, ALUSrc1, jr1, jal1, RegDst1, bne1,jump1,
 MemReadEn2, MemtoReg2, MemWriteEn2, RegWriteEn2, ALUSrc2, jr2, jal2, RegDst2, bne2,jump2,MemReadEn1_EX, MemtoReg1_EX, 
 MemWriteEn1_EX,ALUSrc1_EX, jal1_EX, bne1_EX, jr1_EX,MemReadEn2_EX, MemtoReg2_EX, 
 MemWriteEn2_EX,ALUSrc2_EX, jal2_EX, bne2_EX, jr2_EX;


assign jr1_out = jr1_EX;
assign jr2_out = jr2_EX;
assign jr_addr1_out = readData1_1_EX[9:0] ;
assign jr_addr2_out = readData1_2_EX[9:0] ;

/////////////////////////////////////////
 
assign   ld_hazard =   (MemReadEn1_EX && ((rs1 == DestReg1_EX) || (RegDst1 || Branch1 || MemWriteEn1) &&(rt1 == DestReg1_EX)))
							||(MemReadEn2_EX && ((rs1 == DestReg2_EX) || (RegDst1 || Branch1 || MemWriteEn1) && (rt1 == DestReg2_EX)))
							||(MemReadEn1_EX && ((rs2 == DestReg1_EX) || (RegDst2 || Branch2 || MemWriteEn2) && (rt2 == DestReg1_EX)))
							||(MemReadEn2_EX && ((rs2 == DestReg2_EX) || (RegDst2 || Branch2 || MemWriteEn2) && (rt2 == DestReg2_EX)));
						
assign   jr_hazard = (jr1_EX||jr2_EX) && !ld_hazard; 
////////////////////////////////////////
 
 
 
 
fetch_taken u_fetch_taken(
    .clk           ( clk ),
    .rst           ( rst ),
    .jr            ( jr1_EX | jr2_EX | jr1_in | jr2_in),
    .hold          (  ld_hazard  ),
	 .BranchAddress_1(BranchAddress_1),
	 .BranchAddress_2(BranchAddress_2),
    .correct_en    ( correct_en    ),
	 .nextPC_out        (next_pc_out),
    .reg1Addr      ( jr1_EX ? readData1_1_EX[9:0] : jr2_EX ? readData1_2_EX[9:0] : jr1_in ? jr_addr1_in : jr_addr2_in ),
    .correction    ( correction    ),
    .flush_second  ( flush_second  ),
    .return_addr1  ( return_addr1  ),
    .return_addr2  ( return_addr2  ),
    .instruction_1 ( instruction_1 ),
    .instruction_2  ( instruction_2  )
);




IFID #(52) ifid1(.Q({return_addr1_ID, instruction1_ID, BranchAddress1_ID}),
 
					 .D({return_addr1, instruction_1, BranchAddress_1}),

					 .clk(clk), .reset(rst ), .hold(ld_hazard ), .flush(jr_hazard || flush_IFID)); ///////////////////////////////////////

IFID #(52) ifid2(.Q({return_addr2_ID, instruction2_ID, BranchAddress2_ID}),
 
					 .D({return_addr2, instruction_2, BranchAddress_2}),

					 .clk(clk), .reset(rst ), .hold(ld_hazard ), .flush(flush_second || jr_hazard || flush_IFID)); ///////////////////////////////////////


decode u_decode(
    .clk            ( clk            ),
    .rst            ( rst            ),
    .jal1_WB        ( jal1_WB     ),
    .jal2_WB        ( jal2_WB ),
    .regWrite1_WB   ( regWrite1_WB   ),
    .regWrite2_WB   ( regWrite2_WB   ),
    .writeReg1_WB   ( writeReg1_WB   ),
    .writeReg2_WB   ( writeReg2_WB   ),
    .instruction1   ( instruction1_ID ),
    .instruction2   ( instruction2_ID),
    .writeData1_WB  ( writeData1_WB  ),
    .writeData2_WB  ( writeData2_WB  ),
    .shamt1         ( shamt1         ),
    .shamt2         ( shamt2         ),
    .rs1            ( rs1            ),
    .rt1            ( rt1            ),
    .rs2            ( rs2            ),
    .rt2            ( rt2            ),
	 .ForwardA1   ( ForwardA_1      ),
    .ForwardB1   ( ForwardB_1      ),
    .ForwardA2   ( ForwardA_2      ),
    .ForwardB2   ( ForwardB_2      ),
    .aluRes1_EX     ( aluRes1     ),
    .aluRes2_EX     ( aluRes2     ),
    .aluRes1_MEM    ( aluRes1_MEM_fwd    ),
    .aluRes2_MEM    ( aluRes2_MEM_fwd    ), 
	 .destReg1       ( destReg1       ),
	 .destReg2       ( destReg2       ),
    .Branch1        ( Branch1        ),
    .MemReadEn1     ( MemReadEn1     ),
    .MemtoReg1      ( MemtoReg1      ),
    .MemWriteEn1    ( MemWriteEn1    ),
    .RegWriteEn1    ( RegWriteEn1    ),
    .ALUSrc1        ( ALUSrc1        ),
    .jr1            ( jr1            ),
    .jal1           ( jal1           ),
    .RegDst1        ( RegDst1        ),
    .bne1           ( bne1           ),
    .jump1 	        ( jump1 	       ),
	 .Branch2        ( Branch2        ),
    .MemReadEn2     ( MemReadEn2     ),
    .MemtoReg2      ( MemtoReg2      ),
    .MemWriteEn2    ( MemWriteEn2    ),
    .RegWriteEn2    ( RegWriteEn2    ),
    .ALUSrc2        ( ALUSrc2        ),
    .jr2            ( jr2            ),
    .jal2           ( jal2           ),
    .RegDst2        ( RegDst2        ),
    .bne2           ( bne2           ),
    .jump2   	     ( jump2   	    ),
	 .AluOp1         ( AluOp1         ),
    .AluOp2         ( AluOp2         ),
    .readData1_1    ( readData1_1    ),
    .readData2_1    ( readData2_1    ),
    .extImm1        ( extImm1        ),
    .readData1_2    ( readData1_2    ),
    .readData2_2    ( readData2_2    ),
    .extImm2        ( extImm2        )
);


IDEX #(160) idex1(.Q({shamt1_EX, MemReadEn1_EX, MemtoReg1_EX, MemWriteEn1_EX, RegWriteEn1_EX, ALUSrc1_EX, jal1_EX, ALUOp1_EX, rs1_EX, rt1_EX, DestReg1_EX, readData1_1_EX, readData2_1_EX, extImm1_EX, return_addr1_EX, Branch1_EX, bne1_EX, jr1_EX,BranchAddress1_EX}), 
.D({shamt1, MemReadEn1, MemtoReg1, MemWriteEn1, RegWriteEn1, ALUSrc1, jal1, AluOp1, rs1, rt1, destReg1, readData1_1, readData2_1, extImm1, return_addr1_ID, Branch1, bne1, jr1, BranchAddress1_ID}), 
.clk(clk), .reset(rst), .flush(jr_hazard || ld_hazard || flush_IDEX));



IDEX #(160) idex2(.Q({shamt2_EX, MemReadEn2_EX, MemtoReg2_EX, MemWriteEn2_EX, RegWriteEn2_EX, ALUSrc2_EX, jal2_EX, ALUOp2_EX, rs2_EX, rt2_EX, DestReg2_EX, readData1_2_EX, readData2_2_EX, extImm2_EX, return_addr2_EX, Branch2_EX, bne2_EX, jr2_EX,BranchAddress2_EX}), 
.D({shamt2, MemReadEn2, MemtoReg2, MemWriteEn2, RegWriteEn2, ALUSrc2, jal2, AluOp2, rs2, rt2, destReg2, readData1_2, readData2_2, extImm2, return_addr2_ID, Branch2, bne2, jr2, BranchAddress2_ID}), 
.clk(clk), .reset(rst), .flush(jr_hazard || ld_hazard || flush_IDEX));


execute u_execute(
    .rst          ( rst          ),
    .Branch1      ( Branch1_EX      ),
    .Branch2      ( Branch2_EX      ),
    .ALUSrc1      ( ALUSrc1_EX      ),
    .ALUSrc2      ( ALUSrc2_EX      ),
    .bne1         ( bne1_EX         ),
    .bne2         ( bne2_EX         ),
    .ALUOp1       ( ALUOp1_EX       ),
    .ALUOp2       ( ALUOp2_EX       ),
    .shamt1_EX    ( shamt1_EX    ),
    .shamt2_EX    ( shamt2_EX    ),
    .readData1_1  ( readData1_1_EX  ),
    .readData2_1  ( readData2_1_EX  ),
    .extImm1      ( extImm1_EX      ),
    .extImm2      ( extImm2_EX      ),
    .readData1_2  ( readData1_2_EX  ),
    .readData2_2  ( readData2_2_EX  ),
    .aluRes1      ( aluRes1      ),
    .aluRes2      ( aluRes2      ),
    .taken1       ( taken1       ),
    .taken2       ( taken2       )
);




EXMEM #(100) exmem1(
    .Q({aluRes1_MEM, forwardBRes1_MEM, MemReadEn1_MEM, MemtoReg1_MEM, MemWriteEn1_MEM, RegWriteEn1_MEM, jal1_MEM, DestReg1_MEM, return_addr1_MEM, rt1_MEM,taken1_MEM,Branch1_MEM}), 
    .D({aluRes1, readData2_1_EX, MemReadEn1_EX, MemtoReg1_EX, MemWriteEn1_EX, RegWriteEn1_EX,  jal1_EX, DestReg1_EX, return_addr1_EX,rt1_EX,taken1,Branch1_EX }), 
    .clk(clk), .reset(rst)
);


EXMEM #(100) exmem2(
    .Q({aluRes2_MEM, forwardBRes2_MEM, MemReadEn2_MEM, MemtoReg2_MEM, MemWriteEn2_MEM, RegWriteEn2_MEM, jal2_MEM, DestReg2_MEM, return_addr2_MEM, rt2_MEM,taken2_MEM,Branch2_MEM}), 
    .D({aluRes2, readData2_2_EX, MemReadEn2_EX, MemtoReg2_EX, MemWriteEn2_EX, RegWriteEn2_EX,  jal2_EX, DestReg2_EX, return_addr2_EX,rt2_EX,taken2,Branch2_EX}), 
    .clk(clk), .reset(rst)
);




endmodule