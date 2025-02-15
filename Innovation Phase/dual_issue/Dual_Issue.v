module Dual_Issue(input clk, rst, output [31:0] out1,out2);



wire hold_pc_t ,hold_IFID_t, flush_IFID_t, flush_IDEX_t,correct_en_t,jal1_WB,jal2_WB,regWrite1_WB,regWrite2_WB,
Branch1_t, Branch2_t, taken1_t, taken2_t,taken1_MEM_t,MemReadEn1_MEM_t,MemtoReg1_MEM_t,MemWriteEn1_MEM_t,RegWriteEn1_MEM_t,jal1_MEM_t,
taken2_MEM_t,MemReadEn2_MEM_t,MemtoReg2_MEM_t,MemWriteEn2_MEM_t,RegWriteEn2_MEM_t,jal2_MEM_t,Branch1_MEM_t,Branch2_MEM_t,taken_pipe,
MemtoReg1_WB,MemtoReg2_WB,Branch1_EX_t,Branch2_EX_t,Branch1_EX_n,Branch2_EX_n;

wire[1:0] memFw1,memFw2;
wire [2:0] ForwardA_1_t,ForwardB_1_t,ForwardA_2_t,ForwardB_2_t,ForwardA_1_n,ForwardB_1_n,ForwardA_2_n,ForwardB_2_n;
wire [4:0] writeReg1_WB, writeReg2_WB,DestReg1_MEM_t,DestReg2_MEM_t,rt1_MEM_t,rt2_MEM_t,
rs1_EX_t,rt1_EX_t,rs2_EX_t,rt2_EX_t,rs1_EX_n,rt1_EX_n,rs2_EX_n,rt2_EX_n;
wire [9:0] correction_t,return_addr2_ID_t,return_addr2_EX_t,return_addr1_MEM_t,return_addr2_MEM_t,BranchAddress1_EX_t,BranchAddress2_EX_t,
next_pc_out_t,return_addr1_WB,return_addr2_WB,next_pc_out_n,BTA1,BTA2;
wire [31:0] writeData1_WB, writeData2_WB,aluRes1_WB,aluRes2_WB,Dmem_res1_WB,Dmem_res2_WB,WBMuxOutput1,WBMuxOutput2,
aluRes1_MEM,aluRes2_MEM,aluRes1_MEM_n,aluRes2_MEM_n,forwardBRes1_MEM_n,forwardBRes2_MEM_n;


wire hold_pc_n ,hold_IFID_n, flush_IFID_n, flush_IDEX_n,correct_en_n,
Branch1_n, Branch2_n, taken1_n, taken2_n,taken1_MEM_n,MemReadEn1_MEM_n,MemtoReg1_MEM_n,MemWriteEn1_MEM_n,RegWriteEn1_MEM_n,jal1_MEM_n,
taken2_MEM_n,MemReadEn2_MEM_n,MemtoReg2_MEM_n,MemWriteEn2_MEM_n,RegWriteEn2_MEM_n,jal2_MEM_n,jal2_MEM ,jal1_MEM ,RegWriteEn2_MEM ,
RegWriteEn1_MEM ,MemWriteEn2_MEM ,MemWriteEn1_MEM ,MemtoReg2_MEM ,MemtoReg1_MEM ,MemReadEn2_MEM ,MemReadEn1_MEM ;

wire [4:0] DestReg1_MEM_n,DestReg2_MEM_n,rt1_MEM_n,rt2_MEM_n,rt2_MEM ,rt1_MEM ,DestReg2_MEM ,DestReg1_MEM;
wire [9:0] return_addr2_MEM ,return_addr1_MEM,correction_n,return_addr2_ID_n,return_addr2_EX_n,return_addr1_MEM_n,return_addr2_MEM_n;
wire [31:0] aluRes1_MEM_t,aluRes2_MEM_t,forwardBRes1_MEM_t,forwardBRes2_MEM_t,forwardBRes2_MEM ,forwardBRes1_MEM ,Dmem_res1,Dmem_res2;

reg [31:0] Dmem_data1,Dmem_data2;

 assign out1 = writeData1_WB;
assign out2 = writeData2_WB;

t_pipe u_t_pipe(
    .clk               ( clk               ),
    .rst               ( rst               ),
    .flush_IFID        ( flush_IFID_t      ),
    .flush_IDEX        ( flush_IDEX_t      ),
    .correct_en        ( correct_en_t      ),
    .jal1_WB           ( jal1_WB           ),
    .jal2_WB           ( jal2_WB           ),
    .regWrite1_WB      ( regWrite1_WB      ),
    .regWrite2_WB      ( regWrite2_WB      ),
    .ForwardA_1        ( ForwardA_1_t        ),
    .ForwardB_1        ( ForwardB_1_t        ),
    .ForwardA_2        ( ForwardA_2_t        ),
    .ForwardB_2        ( ForwardB_2_t        ),
    .writeReg1_WB      ( writeReg1_WB      ),
    .writeReg2_WB      ( writeReg2_WB      ),
    .correction        ( correction_t        ),
    .writeData1_WB     ( writeData1_WB     ),
    .writeData2_WB     ( writeData2_WB     ),
    .aluRes1_WB        ( WBMuxOutput1        ),
    .aluRes2_WB        ( WBMuxOutput2        ),
    .Branch1           ( Branch1_t           ),
    .Branch2           ( Branch2_t           ),
    .taken1            ( taken1_t            ),
    .taken2            ( taken2_t            ),
    .taken1_MEM        ( taken1_MEM_t        ),
    .MemReadEn1_MEM    ( MemReadEn1_MEM_t    ),
    .MemtoReg1_MEM     ( MemtoReg1_MEM_t     ),
    .MemWriteEn1_MEM   ( MemWriteEn1_MEM_t   ),
    .RegWriteEn1_MEM   ( RegWriteEn1_MEM_t   ),
    .jal1_MEM          ( jal1_MEM_t          ),
    .taken2_MEM        ( taken2_MEM_t        ),
	 .rs2_EX					(	rs2_EX_t				), 
	 .rt2_EX					(	rt2_EX_t				),
	 .rs1_EX					(	rs1_EX_t				), 
	 .rt1_EX					(	rt1_EX_t				),
    .MemReadEn2_MEM    ( MemReadEn2_MEM_t    ),
    .MemtoReg2_MEM     ( MemtoReg2_MEM_t     ),
    .MemWriteEn2_MEM   ( MemWriteEn2_MEM_t   ),
    .RegWriteEn2_MEM   ( RegWriteEn2_MEM_t   ),
    .jal2_MEM          ( jal2_MEM_t          ),
    .DestReg1_MEM      ( DestReg1_MEM_t      ),
    .rt1_MEM           ( rt1_MEM_t           ),
    .DestReg2_MEM      ( DestReg2_MEM_t      ),
    .rt2_MEM           ( rt2_MEM_t           ),
    .return_addr2_ID   ( return_addr2_ID_t   ),
    .return_addr2_EX   ( return_addr2_EX_t   ),
    .return_addr1_MEM  ( return_addr1_MEM_t  ),
    .return_addr2_MEM  ( return_addr2_MEM_t  ),
    .BranchAddress1_EX ( BranchAddress1_EX_t ),
    .BranchAddress2_EX ( BranchAddress2_EX_t ),
    .next_pc_out       ( next_pc_out_t       ),
    .aluRes1_MEM       ( aluRes1_MEM_t       ),
    .forwardBRes1_MEM  ( forwardBRes1_MEM_t  ),
    .aluRes2_MEM       ( aluRes2_MEM_t       ),
    .forwardBRes2_MEM  ( forwardBRes2_MEM_t  ),
	 .Branch1_MEM		  ( Branch1_MEM_t			),
	 .Branch2_MEM		  ( Branch2_MEM_t			),
	 .Branch1_EX		  ( Branch1_EX_t			),
	 .Branch2_EX		  ( Branch2_EX_t			),
	 .aluRes1_MEM_fwd		(	aluRes1_MEM			),
	 .aluRes2_MEM_fwd		(	aluRes2_MEM		)
);



not_t_pipe u_not_t_pipe(
    .clk               ( clk               ),
    .rst               ( rst               ),
    .flush_IFID        ( flush_IFID_n        ),
    .flush_IDEX        ( flush_IDEX_n        ),
    .correct_en        ( correct_en_n        ),
    .jal1_WB           ( jal1_WB           ),
    .jal2_WB           ( jal2_WB           ),
    .regWrite1_WB      ( regWrite1_WB      ),
    .regWrite2_WB      ( regWrite2_WB      ),
    .ForwardA_1        ( ForwardA_1_n        ),
    .ForwardB_1        ( ForwardB_1_n        ),
    .ForwardA_2        ( ForwardA_2_n        ),
    .ForwardB_2        ( ForwardB_2_n        ),
    .writeReg1_WB      ( writeReg1_WB      ),
    .writeReg2_WB      ( writeReg2_WB      ),
    .correction        ( correction_n        ),
    .writeData1_WB     ( writeData1_WB     ),
    .writeData2_WB     ( writeData2_WB     ),
    .aluRes1_WB        ( WBMuxOutput1        ),
    .aluRes2_WB        ( WBMuxOutput2        ),
    .Branch1           ( Branch1_n           ),
    .Branch2           ( Branch2_n           ),
    .taken1            ( taken1_n            ),
    .taken2            ( taken2_n            ),
    .taken1_MEM        ( taken1_MEM_n        ),
    .MemReadEn1_MEM    ( MemReadEn1_MEM_n    ),
    .MemtoReg1_MEM     ( MemtoReg1_MEM_n     ),
    .MemWriteEn1_MEM   ( MemWriteEn1_MEM_n   ),
    .RegWriteEn1_MEM   ( RegWriteEn1_MEM_n   ),
    .jal1_MEM          ( jal1_MEM_n          ),
    .taken2_MEM        ( taken2_MEM_n        ),
	 .rs2_EX					(	rs2_EX_n				), 
	 .rt2_EX					(	rt2_EX_n				),
	 .rs1_EX					(	rs1_EX_n				), 
	 .rt1_EX					(	rt1_EX_n				),
    .MemReadEn2_MEM    ( MemReadEn2_MEM_n    ),
    .MemtoReg2_MEM     ( MemtoReg2_MEM_n     ),
    .MemWriteEn2_MEM   ( MemWriteEn2_MEM_n   ),
    .RegWriteEn2_MEM   ( RegWriteEn2_MEM_n   ),
    .jal2_MEM          ( jal2_MEM_n          ),
    .DestReg1_MEM      ( DestReg1_MEM_n      ),
    .rt1_MEM           ( rt1_MEM_n           ),
    .DestReg2_MEM      ( DestReg2_MEM_n      ),
    .rt2_MEM           ( rt2_MEM_n           ),
    .return_addr2_ID   ( return_addr2_ID_n   ),
    .return_addr2_EX   ( return_addr2_EX_n   ),
    .return_addr1_MEM  ( return_addr1_MEM_n  ),
    .return_addr2_MEM  ( return_addr2_MEM_n  ),
    .next_pc_out       ( next_pc_out_n       ),
    .aluRes1_MEM       ( aluRes1_MEM_n       ),
    .forwardBRes1_MEM  ( forwardBRes1_MEM_n  ),
    .aluRes2_MEM       ( aluRes2_MEM_n       ),
    .forwardBRes2_MEM  ( forwardBRes2_MEM_n  ),
	 .BranchAddress_1_ID (BTA1),
	 .BranchAddress_2_ID (BTA2),
	 .Branch1_EX		  ( Branch1_EX_n			),
	 .Branch2_EX		  ( Branch2_EX_n			),
	 .aluRes1_MEM_fwd		(	aluRes1_MEM			),
	 .aluRes2_MEM_fwd		(	aluRes2_MEM		)
);

branch_control u_branch_control(
    .clk                        ( clk                        ),
    .rst                        ( rst                        ),
    .Branch1_t                  ( Branch1_EX_t               ),
    .Branch2_t                  ( Branch2_EX_t               ),
    .Branch1_n                  ( Branch1_EX_n               ),
    .Branch2_n                  ( Branch2_EX_n               ),
    .Branch1_t_ID               ( Branch1_t 	                ),
    .Branch2_t_ID               ( Branch2_t	                ),
    .Branch1_n_ID               ( Branch1_n                  ),
    .Branch2_n_ID               ( Branch2_n 		             ),
    .taken1_t                   ( taken1_t                   ),
    .taken2_t                   ( taken2_t                   ),
    .taken1_n                   ( taken1_n                   ),
    .taken2_n                   ( taken2_n                   ),
    .nextPC_n                   ( next_pc_out_n              ),
    .nextPC_t                   ( next_pc_out_t              ),
    .BTA1_n_ID                  ( BTA1	                      ),
    .BTA2_n_ID                  ( BTA2 	                   ),
    .nextPC_ID_n                ( return_addr2_ID_n	  		),
    .nextPC_ID_t					  ( return_addr2_ID_t			 ),
	 .flush_IFID_t 				  ( flush_IFID_t				    ),
    .flush_IDEX_t               ( flush_IDEX_t               ),
    .correct_en_t               ( correct_en_t               ),
    .flush_IFID_n               ( flush_IFID_n               ),
    .flush_IDEX_n               ( flush_IDEX_n               ),
    .correct_en_n               ( correct_en_n               ),
    .pipe_valid                 ( taken_pipe                 ),
    .correction_n               ( correction_n               ),
    .correction_t               ( correction_t               )
);


forwarding_unit u_forwarding_unit_t(
    .rs1_ex          ( rs1_EX_t        ),
    .rt1_ex          ( rt1_EX_t        ),
    .rs2_ex          ( rs2_EX_t        ),
    .rt2_ex          ( rt2_EX_t        ),
    .dest1_mem       ( DestReg1_MEM    ),
    .dest2_mem       ( DestReg2_MEM    ),
    .dest1_wb        ( writeReg1_WB        ),
    .dest2_wb        ( writeReg2_WB        ),
    .rt1_mem         ( rt1_MEM         ),
    .rt2_mem         ( rt2_MEM         ),
    .rst             ( rst             ),
    .regwrite1_mem   ( RegWriteEn1_MEM ),
    .regwrite2_mem   ( RegWriteEn2_MEM ),
    .regwrite1_wb    ( regWrite1_WB    ),
    .regwrite2_wb    ( regWrite2_WB    ),
    .MemWriteEn1_MEM ( MemWriteEn1_MEM ),
    .MemWriteEn2_MEM ( MemWriteEn2_MEM ),
    .ForwardA1       ( ForwardA_1_t       ),
    .ForwardB1       ( ForwardB_1_t       ),
    .ForwardA2       ( ForwardA_2_t       ),
    .ForwardB2       ( ForwardB_2_t       ),
    .memFw1          (           ),
    .memFw2          (           )
);



forwarding_unit u_forwarding_unit_n(
    .rs1_ex          ( rs1_EX_n        ),
    .rt1_ex          ( rt1_EX_n        ),
    .rs2_ex          ( rs2_EX_n        ),
    .rt2_ex          ( rt2_EX_n        ),
    .dest1_mem       ( DestReg1_MEM    ),
    .dest2_mem       ( DestReg2_MEM    ),
    .dest1_wb        ( writeReg1_WB        ),
    .dest2_wb        ( writeReg2_WB        ),
    .rt1_mem         ( rt1_MEM         ),
    .rt2_mem         ( rt2_MEM         ),
    .rst             ( rst             ),
    .regwrite1_mem   ( RegWriteEn1_MEM ),
    .regwrite2_mem   ( RegWriteEn2_MEM ),
    .regwrite1_wb    ( regWrite1_WB    ),
    .regwrite2_wb    ( regWrite2_WB    ),
    .MemWriteEn1_MEM ( MemWriteEn1_MEM ),
    .MemWriteEn2_MEM ( MemWriteEn2_MEM ),
    .ForwardA1       ( ForwardA_1_n       ),
    .ForwardB1       ( ForwardB_1_n       ),
    .ForwardA2       ( ForwardA_2_n       ),
    .ForwardB2       ( ForwardB_2_n       ),
    .memFw1          ( memFw1          ),
    .memFw2          ( memFw2          )
);




mux2x1 #(178) memMUX  (.in1({aluRes1_MEM_n,aluRes2_MEM_n,forwardBRes2_MEM_n,forwardBRes1_MEM_n,return_addr2_MEM_n,return_addr1_MEM_n,rt2_MEM_n,rt1_MEM_n,DestReg2_MEM_n,
								DestReg1_MEM_n,jal2_MEM_n,jal1_MEM_n,RegWriteEn2_MEM_n,RegWriteEn1_MEM_n,MemWriteEn2_MEM_n,MemWriteEn1_MEM_n,
								MemtoReg2_MEM_n,MemtoReg1_MEM_n,MemReadEn2_MEM_n,MemReadEn1_MEM_n})
							,.in2({aluRes1_MEM_t,aluRes2_MEM_t,forwardBRes2_MEM_t,forwardBRes1_MEM_t,return_addr2_MEM_t,return_addr1_MEM_t,rt2_MEM_t,rt1_MEM_t,DestReg2_MEM_t,
								DestReg1_MEM_t,jal2_MEM_t,jal1_MEM_t,RegWriteEn2_MEM_t,RegWriteEn1_MEM_t,MemWriteEn2_MEM_t,MemWriteEn1_MEM_t,
								MemtoReg2_MEM_t,MemtoReg1_MEM_t,MemReadEn2_MEM_t,MemReadEn1_MEM_t})
							,.s(taken_pipe)
							,.out({aluRes1_MEM,aluRes2_MEM,forwardBRes2_MEM ,forwardBRes1_MEM ,return_addr2_MEM ,return_addr1_MEM ,rt2_MEM ,rt1_MEM ,DestReg2_MEM ,
								DestReg1_MEM ,jal2_MEM ,jal1_MEM ,RegWriteEn2_MEM ,RegWriteEn1_MEM ,MemWriteEn2_MEM ,MemWriteEn1_MEM ,
								MemtoReg2_MEM ,MemtoReg1_MEM ,MemReadEn2_MEM ,MemReadEn1_MEM }));


always @(*) begin
	if(memFw1 == 2'b01) Dmem_data1 = WBMuxOutput1;
	else if (memFw1 == 2'b10) Dmem_data1 = WBMuxOutput2;
	else Dmem_data1 = forwardBRes1_MEM;
	
	if(memFw2 == 2'b01) Dmem_data2 = WBMuxOutput1;
	else if (memFw2 == 2'b10) Dmem_data2 = WBMuxOutput2;
	else Dmem_data2 = forwardBRes1_MEM;
end

dataMemory DM(.address_a(aluRes1_MEM),
	.address_b(aluRes2_MEM),
	.clock(~clk),
	.data_a(Dmem_data1),
	.data_b(Dmem_data2),
	.wren_a(MemWriteEn1_MEM),
	.wren_b(MemWriteEn2_MEM),
	.q_a(Dmem_res1),
	.q_b(Dmem_res2));


MEMWB #(82) memwb1(.Q({aluRes1_WB, writeReg1_WB, Dmem_res1_WB, return_addr1_WB, jal1_WB, MemtoReg1_WB, regWrite1_WB}),
.D({aluRes1_MEM, DestReg1_MEM, Dmem_res1, return_addr1_MEM, jal1_MEM, MemtoReg1_MEM, RegWriteEn1_MEM}), 
.clk(clk), .reset(rst));	
	
MEMWB #(82) memwb2(.Q({aluRes2_WB, writeReg2_WB, Dmem_res2_WB, return_addr2_WB, jal2_WB, MemtoReg2_WB, regWrite2_WB}),
.D({aluRes2_MEM, DestReg2_MEM, Dmem_res2, return_addr2_MEM, jal2_MEM, MemtoReg2_MEM, RegWriteEn2_MEM}), 
.clk(clk), .reset(rst));	
		
mux2x1 #(32) WBMux1(.in1(aluRes1_WB), .in2(Dmem_res1_WB), .s(MemtoReg1_WB), .out(WBMuxOutput1));
mux2x1 #(32) WBMux2(.in1(aluRes2_WB), .in2(Dmem_res2_WB), .s(MemtoReg2_WB), .out(WBMuxOutput2));
	
	
	
mux2x1 #(32) WritePc1(.in1(WBMuxOutput1),.in2({22'b0,return_addr1_WB}),.s(jal1_WB),.out(writeData1_WB));
mux2x1 #(32) WritePc2(.in1(WBMuxOutput2),.in2({22'b0,return_addr2_WB}),.s(jal2_WB),.out(writeData2_WB));
	

	

endmodule






















