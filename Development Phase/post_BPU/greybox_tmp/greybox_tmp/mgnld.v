//lpm_compare CBX_SINGLE_OUTPUT_FILE="ON" LPM_PIPELINE=1 LPM_REPRESENTATION="UNSIGNED" LPM_TYPE="LPM_COMPARE" LPM_WIDTH=8 aeb aneb clock dataa datab
//VERSION_BEGIN 22.1 cbx_mgl 2023:07:21:07:12:36:SC cbx_stratixii 2023:07:21:07:12:21:SC cbx_util_mgl 2023:07:21:07:12:21:SC  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2023  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.



//synthesis_resources = lpm_compare 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mgnld
	( 
	aeb,
	aneb,
	clock,
	dataa,
	datab) /* synthesis synthesis_clearbox=1 */;
	output   aeb;
	output   aneb;
	input   clock;
	input   [7:0]  dataa;
	input   [7:0]  datab;

	wire  wire_mgl_prim1_aeb;
	wire  wire_mgl_prim1_aneb;

	lpm_compare   mgl_prim1
	( 
	.aeb(wire_mgl_prim1_aeb),
	.aneb(wire_mgl_prim1_aneb),
	.clock(clock),
	.dataa(dataa),
	.datab(datab));
	defparam
		mgl_prim1.lpm_pipeline = 1,
		mgl_prim1.lpm_representation = "UNSIGNED",
		mgl_prim1.lpm_type = "LPM_COMPARE",
		mgl_prim1.lpm_width = 8;
	assign
		aeb = wire_mgl_prim1_aeb,
		aneb = wire_mgl_prim1_aneb;
endmodule //mgnld
//VALID FILE
