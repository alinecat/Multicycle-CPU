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
// CREATED		"Fri May 08 13:36:07 2020"

module datapath(
	CLK,
	RESET,
	mux_alu_shift,
	exec_enable,
	alu_pc_sel,
	ra_rb_enable,
	srcA_sel,
	srcB_mem_reg_sel,
	regf_WE,
	Inst_en,
	mem_buff_en,
	WD3_src_sel,
	mem_WE,
	PC_WE,
	LR_EN,
	alu_ctr,
	mem_addr_src_sel,
	PC_SRC,
	N,
	Z,
	C,
	V,
	INS
);


input wire	CLK;
input wire	RESET;
input wire	mux_alu_shift;
input wire	exec_enable;
input wire	alu_pc_sel;
input wire	ra_rb_enable;
input wire	srcA_sel;
input wire	srcB_mem_reg_sel;
input wire	regf_WE;
input wire	Inst_en;
input wire	mem_buff_en;
input wire	WD3_src_sel;
input wire	mem_WE;
input wire	PC_WE;
input wire	LR_EN;
input wire	[2:0] alu_ctr;
input wire	[1:0] mem_addr_src_sel;
input wire	[1:0] PC_SRC;
output wire	N;
output wire	Z;
output wire	C;
output wire	V;
output wire	[15:0] INS;

wire	[15:0] inp0;
wire	[15:0] inp2;
wire	[15:0] INST;
wire	[15:0] ZERO;
wire	[15:0] SYNTHESIZED_WIRE_0;
wire	[15:0] SYNTHESIZED_WIRE_27;
wire	[15:0] SYNTHESIZED_WIRE_2;
wire	[15:0] SYNTHESIZED_WIRE_3;
wire	[15:0] SYNTHESIZED_WIRE_4;
wire	[15:0] SYNTHESIZED_WIRE_28;
wire	[15:0] SYNTHESIZED_WIRE_29;
wire	[15:0] SYNTHESIZED_WIRE_30;
wire	[15:0] SYNTHESIZED_WIRE_10;
wire	[15:0] SYNTHESIZED_WIRE_31;
wire	[15:0] SYNTHESIZED_WIRE_13;
wire	[15:0] SYNTHESIZED_WIRE_32;
wire	[15:0] SYNTHESIZED_WIRE_15;
wire	[15:0] SYNTHESIZED_WIRE_17;
wire	[15:0] SYNTHESIZED_WIRE_18;
wire	[15:0] SYNTHESIZED_WIRE_19;
wire	[15:0] SYNTHESIZED_WIRE_21;
wire	[15:0] SYNTHESIZED_WIRE_24;
wire	[15:0] SYNTHESIZED_WIRE_25;





const_val_gen	b2v_ADD4(
	.out(SYNTHESIZED_WIRE_21));
	defparam	b2v_ADD4.N = 1;
	defparam	b2v_ADD4.W = 16;

assign	inp0[15:4] = ZERO[15:4];


assign	inp2[15:7] = ZERO[15:7];



dff_en	b2v_ALU_SHIFT_DATA(
	.clk(CLK),
	.reset(RESET),
	.en(exec_enable),
	.d(SYNTHESIZED_WIRE_0),
	.q(SYNTHESIZED_WIRE_18));
	defparam	b2v_ALU_SHIFT_DATA.W = 16;


mux_2x1	b2v_ALU_SHIFT_SEL(
	.sel(mux_alu_shift),
	.inp0(SYNTHESIZED_WIRE_27),
	.inp1(SYNTHESIZED_WIRE_2),
	.out(SYNTHESIZED_WIRE_0));
	defparam	b2v_ALU_SHIFT_SEL.W = 16;


alu_mult	b2v_Arithmetic_Logic_Unit(
	.ALU_Control(alu_ctr),
	.Src_A(SYNTHESIZED_WIRE_3),
	.Src_B(SYNTHESIZED_WIRE_4),
	.N(N),
	.Z(Z),
	.C(C),
	.V(V),
	.ALU_Result(SYNTHESIZED_WIRE_27));

assign	inp2[6:0] = INST[6:0];



dff_en	b2v_INSTR_REG(
	.clk(CLK),
	.reset(RESET),
	.en(Inst_en),
	.d(SYNTHESIZED_WIRE_28),
	.q(INST));
	defparam	b2v_INSTR_REG.W = 16;


dff_en	b2v_Link_Register(
	.clk(CLK),
	.reset(RESET),
	.en(LR_EN),
	.d(SYNTHESIZED_WIRE_29),
	.q(SYNTHESIZED_WIRE_13));
	defparam	b2v_Link_Register.W = 16;


mux_4x1	b2v_Mem_ADDR_SRC(
	.inp0(SYNTHESIZED_WIRE_29),
	.inp1(SYNTHESIZED_WIRE_30),
	.inp2(inp2),
	.inp3(inp0),
	.sel(mem_addr_src_sel),
	.out(SYNTHESIZED_WIRE_10));
	defparam	b2v_Mem_ADDR_SRC.W = 16;


dff_en	b2v_MEM_DATA_REG(
	.clk(CLK),
	.reset(RESET),
	.en(mem_buff_en),
	.d(SYNTHESIZED_WIRE_28),
	.q(SYNTHESIZED_WIRE_32));
	defparam	b2v_MEM_DATA_REG.W = 16;


memory	b2v_MEMORY(
	.CLK(CLK),
	.WE(mem_WE),
	.ADDR(SYNTHESIZED_WIRE_10),
	.WD(SYNTHESIZED_WIRE_31),
	.RD(SYNTHESIZED_WIRE_28));


mux_4x1	b2v_PC_SRC_SEL(
	.inp0(SYNTHESIZED_WIRE_27),
	.inp1(SYNTHESIZED_WIRE_13),
	.inp2(inp2),
	.inp3(SYNTHESIZED_WIRE_32),
	.sel(PC_SRC),
	.out(SYNTHESIZED_WIRE_15));
	defparam	b2v_PC_SRC_SEL.W = 16;


pc	b2v_program_counter(
	.CLK(CLK),
	.PC_en(PC_WE),
	.RST(RESET),
	.PC_IN(SYNTHESIZED_WIRE_15),
	.PC_OUT(SYNTHESIZED_WIRE_29));


dff_en	b2v_RD1_REG(
	.clk(CLK),
	.reset(RESET),
	.en(ra_rb_enable),
	.d(SYNTHESIZED_WIRE_30),
	.q(SYNTHESIZED_WIRE_31));
	defparam	b2v_RD1_REG.W = 16;


dff_en	b2v_RD2_REG(
	.clk(CLK),
	.reset(RESET),
	.en(ra_rb_enable),
	.d(SYNTHESIZED_WIRE_17),
	.q(SYNTHESIZED_WIRE_24));
	defparam	b2v_RD2_REG.W = 16;


mux_2x1	b2v_REGF_WRITE_SRC(
	.sel(WD3_src_sel),
	.inp0(inp0),
	.inp1(SYNTHESIZED_WIRE_18),
	.out(SYNTHESIZED_WIRE_19));
	defparam	b2v_REGF_WRITE_SRC.W = 16;


register_file	b2v_REGFILE(
	.CLK(CLK),
	.WE(regf_WE),
	.RA1(INST[6:4]),
	.RA2(INST[3:1]),
	.WA3(INST[9:7]),
	.WD3(SYNTHESIZED_WIRE_19),
	.RD1(SYNTHESIZED_WIRE_30),
	.RD2(SYNTHESIZED_WIRE_17));

assign	inp0[3:0] = INST[3:0];



shifter	b2v_SHFT(
	.imm(INST[3:0]),
	.inp(SYNTHESIZED_WIRE_31),
	.sh(INST[12:10]),
	.out(SYNTHESIZED_WIRE_2));


mux_2x1	b2v_SRCA_MUX(
	.sel(srcA_sel),
	.inp0(SYNTHESIZED_WIRE_21),
	.inp1(SYNTHESIZED_WIRE_31),
	.out(SYNTHESIZED_WIRE_3));
	defparam	b2v_SRCA_MUX.W = 16;


mux_2x1	b2v_SRCB_MUX1(
	.sel(srcB_mem_reg_sel),
	.inp0(SYNTHESIZED_WIRE_32),
	.inp1(SYNTHESIZED_WIRE_24),
	.out(SYNTHESIZED_WIRE_25));
	defparam	b2v_SRCB_MUX1.W = 16;


mux_2x1	b2v_SRCb_MUX2(
	.sel(alu_pc_sel),
	.inp0(SYNTHESIZED_WIRE_25),
	.inp1(SYNTHESIZED_WIRE_29),
	.out(SYNTHESIZED_WIRE_4));
	defparam	b2v_SRCb_MUX2.W = 16;


const_val_gen	b2v_zreros(
	.out(ZERO));
	defparam	b2v_zreros.N = 1'b0;
	defparam	b2v_zreros.W = 16;

assign	INS = INST;

endmodule
