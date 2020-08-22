// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
// CREATED		"Thu Apr 23 12:37:27 2020"

module combined(
	CLK,
	RST
);


input wire	CLK;
input wire	RST;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[15:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	[2:0] SYNTHESIZED_WIRE_16;
wire	[1:0] SYNTHESIZED_WIRE_17;
wire	[1:0] SYNTHESIZED_WIRE_18;





Controller	b2v_inst(
	.clock(CLK),
	.reset(RST),
	.Z(SYNTHESIZED_WIRE_0),
	.C(SYNTHESIZED_WIRE_1),
	.INST(SYNTHESIZED_WIRE_2),
	.mux_alu_shift(SYNTHESIZED_WIRE_3),
	.exec_enable(SYNTHESIZED_WIRE_4),
	.alu_pc_sel(SYNTHESIZED_WIRE_5),
	.ra_rb_enable(SYNTHESIZED_WIRE_6),
	.srcA_sel(SYNTHESIZED_WIRE_7),
	.srcB_mem_reg_sel(SYNTHESIZED_WIRE_8),
	.regf_WE(SYNTHESIZED_WIRE_9),
	.Inst_en(SYNTHESIZED_WIRE_10),
	.mem_buff_en(SYNTHESIZED_WIRE_11),
	.WD3_src_sel(SYNTHESIZED_WIRE_12),
	.mem_WE(SYNTHESIZED_WIRE_13),
	.PC_WE(SYNTHESIZED_WIRE_14),
	.LR_EN(SYNTHESIZED_WIRE_15),
	.alu_ctr(SYNTHESIZED_WIRE_16),
	.mem_addr_src_sel(SYNTHESIZED_WIRE_17),
	.PC_SRC(SYNTHESIZED_WIRE_18));


datapath	b2v_inst3(
	.mux_alu_shift(SYNTHESIZED_WIRE_3),
	.exec_enable(SYNTHESIZED_WIRE_4),
	.alu_pc_sel(SYNTHESIZED_WIRE_5),
	.ra_rb_enable(SYNTHESIZED_WIRE_6),
	.srcA_sel(SYNTHESIZED_WIRE_7),
	.srcB_mem_reg_sel(SYNTHESIZED_WIRE_8),
	.regf_WE(SYNTHESIZED_WIRE_9),
	.Inst_en(SYNTHESIZED_WIRE_10),
	.mem_buff_en(SYNTHESIZED_WIRE_11),
	.WD3_src_sel(SYNTHESIZED_WIRE_12),
	.mem_WE(SYNTHESIZED_WIRE_13),
	.PC_WE(SYNTHESIZED_WIRE_14),
	.LR_EN(SYNTHESIZED_WIRE_15),
	.CLK(CLK),
	.RESET(RST),
	.alu_ctr(SYNTHESIZED_WIRE_16),
	.mem_addr_src_sel(SYNTHESIZED_WIRE_17),
	.PC_SRC(SYNTHESIZED_WIRE_18),
	
	.Z(SYNTHESIZED_WIRE_0),
	.C(SYNTHESIZED_WIRE_1),
	
	.INS(SYNTHESIZED_WIRE_2));


endmodule
