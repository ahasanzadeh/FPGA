// megafunction wizard: %LPM_CONSTANT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_CONSTANT 

// ============================================================
// File Name: cof.v
// Megafunction Name(s):
// 			LPM_CONSTANT
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 14.0.2 Build 209 09/17/2014 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, the Altera Quartus II License Agreement,
//the Altera MegaCore Function License Agreement, or other 
//applicable license agreement, including, without limitation, 
//that your use is for the sole purpose of programming logic 
//devices manufactured by Altera and sold by Altera or its 
//authorized distributors.  Please refer to the applicable 
//agreement for further details.


//lpm_constant ENABLE_RUNTIME_MOD="YES" INSTANCE_NAME="cof" LPM_CVALUE=4127 LPM_WIDTH=16 result
//VERSION_BEGIN 14.0 cbx_lpm_constant 2014:09:17:18:55:21:SJ cbx_mgl 2014:09:17:19:03:37:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = sld_mod_ram_rom 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  cof_lpm_constant
	( 
	result) /* synthesis synthesis_clearbox=1 */;
	output   [15:0]  result;

	wire  [15:0]   wire_mgl_prim1_data_write;

	sld_mod_ram_rom   mgl_prim1
	( 
	.data_write(wire_mgl_prim1_data_write));
	defparam
		mgl_prim1.cvalue = 16'b0100000100100111,
		mgl_prim1.is_data_in_ram = 0,
		mgl_prim1.is_readable = 0,
		mgl_prim1.node_name = 1668244992,
		mgl_prim1.numwords = 1,
		mgl_prim1.shift_count_bits = 5,
		mgl_prim1.width_word = 16,
		mgl_prim1.widthad = 1;
	assign
		result = wire_mgl_prim1_data_write;
endmodule //cof_lpm_constant
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module cof (
	result)/* synthesis synthesis_clearbox = 1 */;

	output	[15:0]  result;

	wire [15:0] sub_wire0;
	wire [15:0] result = sub_wire0[15:0];

	cof_lpm_constant	cof_lpm_constant_component (
				.result (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "MAX 10 FPGA"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "1"
// Retrieval info: PRIVATE: JTAG_ID STRING "cof"
// Retrieval info: PRIVATE: Radix NUMERIC "16"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
// Retrieval info: PRIVATE: Value NUMERIC "16679"
// Retrieval info: PRIVATE: nBit NUMERIC "16"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_CVALUE NUMERIC "16679"
// Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=YES, INSTANCE_NAME=cof"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_CONSTANT"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "16"
// Retrieval info: USED_PORT: result 0 0 16 0 OUTPUT NODEFVAL "result[15..0]"
// Retrieval info: CONNECT: result 0 0 16 0 @result 0 0 16 0
// Retrieval info: GEN_FILE: TYPE_NORMAL cof.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL cof.inc TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL cof.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL cof.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL cof_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL cof_bb.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL cof_syn.v TRUE
// Retrieval info: LIB_FILE: lpm