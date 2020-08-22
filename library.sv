/* System Verilog Library 
for Fundamental Components*/

/*Ali Necat Karakuloglu*/


/*CONSTANT VALUE GENERATOR*/

//Concatenation is used to arrange the size and the bit value

module const_val_gen #(parameter W=128, parameter N= 1'b1)  (out);


	output wire [W-1:0] out        ; 
	
	
	assign out[W-1:0] = {W{N}}     ; //Concatenation of N parameters

endmodule
/*CONSTANT VALUE GENERATOR*/


/*DECODER*/

//A decoder representation in data flow level
module decoder_2x4 (inp, out);
	
	input   [1:0] inp;
	output  [3:0] out;
	
	assign out[0] = (~inp[0]) & (~inp[1]) ;
	assign out[1] = ( inp[0]) & (~inp[1]) ;
	assign out[2] = (~inp[0]) & ( inp[1]) ;
	assign out[3] = ( inp[0]) & ( inp[1]) ;
	
endmodule

/*DECODER*/

/*DECODER*/
module decoder_4x16 (inp, out);

   output [15:0] out;
   input [3:0]   inp;
   parameter val = 16'h0001;

assign out   = (inp == 4'b0000) ? val   :
               (inp == 4'b0001) ? val<<1:
               (inp == 4'b0010) ? val<<2:
               (inp == 4'b0011) ? val<<3:
               (inp == 4'b0100) ? val<<4:
               (inp == 4'b0101) ? val<<5:
               (inp == 4'b0110) ? val<<6:
               (inp == 4'b0111) ? val<<7:
               (inp == 4'b1000) ? val<<8:
               (inp == 4'b1001) ? val<<9:
               (inp == 4'b1010) ? val<<10:
               (inp == 4'b1011) ? val<<11:
               (inp == 4'b1100) ? val<<12:
               (inp == 4'b1101) ? val<<13:
               (inp == 4'b1110) ? val<<14:
               (inp == 4'b1111) ? val<<15: 16'bxxxx_xxxx_xxxx_xxxx;

endmodule


/*DECODER*/



/*MULTPLEXER 4x1*/

//Behaivoral description of a 4x1 W-bit multiplexer
module mux_4x1 #(parameter W= 4) (sel, inp0, inp1, inp2, inp3, out);
	
	input        [W-1:0] inp0 ;
	input        [W-1:0] inp1 ;
	input        [W-1:0] inp2 ;
	input        [W-1:0] inp3 ;
	input   		 [1:0]   sel  ;
	output  reg  [W-1:0] out  ;
	
	always @(inp0, inp1, inp2, inp3, sel)
	begin
		case(sel)
			2'b00: out = inp0;
			2'b01: out = inp1;
			2'b10: out = inp2;
			2'b11: out = inp3;
		endcase
	end
					 
endmodule	
/*MULTPLEXER 4x1*/




/*MULTPLEXER 2x1*/

//Similar design to 4x1 mux. But simplified version.
module mux_2x1 #(parameter W= 4) (sel, inp0, inp1, out);
	
	input        [W-1:0] inp0 ;
	input        [W-1:0] inp1 ;
	input                sel  ;
	output  reg  [W-1:0] out  ;
	
	
	always @(inp0, inp1, sel)
	begin
		case(sel)
			2'b0: out = inp0;
			2'b1: out = inp1;
		endcase
	end
	
endmodule	
/*MULTPLEXER 2x1*/



/*ALU*/



//According to the given  operation table the ALU is designed in 
//behavioral level. 

//Overflow detection//

//Addition: If the sign of the both input are the same,
//and, the sign of the result is different than the result
//there is an overflow.

//Subtraciton: If the signs of the both input are the opposite 
//and, the sign of the result is different from the minuend. There is an 
//overflow.


//N and Z flags are determined by the state of the result.


module alu #(parameter W= 8) (A, B, RES, ALU_CTRL, N, Z, CO, OVF);

	input	signed [W-1:0] A		 ;
	input	signed [W-1:0] B		 ;
	input       [2:0]   ALU_CTRL;


	output reg [W-1:0] RES	; //Result
	output reg N, Z, CO, OVF; //Flags


always@(A, B, ALU_CTRL)
	begin
		case(ALU_CTRL)
		3'b000:
			begin
				{CO,RES} = A+B   ; //Addition
				if (A[W-1] ~^ B[W-1])
					OVF = RES[W-1] ^ A[W-1];
				else
					OVF = 0;        //Overflow Add
			end	
		3'b001:
			begin
				{CO,RES} = A-B   ;
				if (A[W-1] ^ B[W-1])
					OVF = RES[W-1] ^ A[W-1];
				else
					OVF = 0;        //Overflow Sub
			end
		3'b010:
			begin
				{CO,RES} = B-A   ;
				if (A[W-1] ^ B[W-1])
					OVF = RES[W-1] ^ B[W-1];
				else
					OVF = 0;        //Overflow Sub
			end
		3'b011:
			begin
				RES = A&(~B);
				CO = 0		 	  ;
				OVF = 0			  ;	
			end
		3'b100:
			begin
				RES = A&B   ;
				CO = 0		     ;
				OVF = 0			  ;					
			end
		3'b101:
			begin
				RES = A|B   ;
				CO = 0		     ;
				OVF = 0			  ;				
			end
		3'b110:
			begin
				RES = A^B   ;
				CO = 0		     ;
				OVF = 0			  ;	
			end
		3'b111:
			begin
				RES = A~^B  ;
				CO = 0		     ;
				OVF = 0			  ;	
			end
		endcase
	N = RES[W-1]			  ;
	Z = (RES == {W{1'b0}}) ;
		
	end

endmodule

/*ALU*/


/*Simple Register With Synchronous Reset*/


//According to the RST input the register is cleared or not.
//Note that the control of the condition is made at the positive edge of the clock
//A behavioral design. 
module reg_w_rst #(parameter W=4) (inp, out, CLK, RST);

input         RST, CLK ;
input      [W-1:0] inp ;
output reg [W-1:0] out ;


always@(posedge CLK)
begin
	if (RST == 1'b0)
		out <= inp		  ;
	else
		out <= {W{1'b0}} ;
end


endmodule
/*Simple Register With Synchronous Reset*/



/*Register With Synchronous Reset And Write Enable*/


//Addition to the previous register design, a condition of wirte enable is added to 
//satisfy the requirements.
module reg_w_rst_we #(parameter W=32) (inp, out, CLK, RST, WE);

input     WE, RST, CLK ;
input      [W-1:0] inp ;
output reg [W-1:0] out ;

initial
begin
	out[W-1] = 0;
end

always@(posedge CLK)
begin
	if ((RST == 1'b0)&(WE == 1'b1))
		out <= inp       ;
	if (RST == 1'b1)
		out <= {W{1'b0}} ;// Concatenation
end


endmodule
/*Register With Synchronous Reset And Write Enable*/


/*Shift Register With Parallel And Serial Load*/

//A behavioral realization of the truth table given in the Lab manual.
//Condition priority is handled by using nested if statements.

module reg_sl #(parameter W=4) (inp, out, CLK, RST, PS, RL, SiL, SiR);

input   RL, PS, SiL,
		  RST, CLK, SiR  ;
input      [W-1:0] inp ;
output reg [W-1:0] out ;


always@(posedge CLK)
begin
	if (RST== 1'b0)
	begin
		
		if (PS == 1'b0)
		begin
			
			if (RL == 1'b0)
			begin
				out[W-1:1] <= out[W-2:0] ;
				out[0]     <= SiR        ;
			end
			
			else
			begin
				out[W-2:0] <= out[W-1:1] ;
				out[W-1]     <= SiL      ;
			end
			
		end
		
		else
		begin
			out <= inp ;
		end
	
	
	end
	
	else
	begin
		out <= {W{1'b0}} ;
	end

	
end


endmodule
/*Shift Register With Parallel And Serial Load*/



/* 16x1 MUX*/
module mux_16x1(
	IN0,
	IN1,
	IN2,
	IN3,
	IN4,
	IN5,
	IN6,
	IN7,
	IN8,
	IN9,
	INA,
	INB,
	INC,
	IND,
	INE,
	INF,
	SEL,
	OUT
);

parameter	W = 32;

input wire	[31:0] IN0;
input wire	[31:0] IN1;
input wire	[31:0] IN2;
input wire	[31:0] IN3;
input wire	[31:0] IN4;
input wire	[31:0] IN5;
input wire	[31:0] IN6;
input wire	[31:0] IN7;
input wire	[31:0] IN8;
input wire	[31:0] IN9;
input wire	[31:0] INA;
input wire	[31:0] INB;
input wire	[31:0] INC;
input wire	[31:0] IND;
input wire	[31:0] INE;
input wire	[31:0] INF;
input wire	[3:0] SEL;
output wire	[31:0] OUT;

wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_3;





mux_4x1	b2v_inst(
	.inp0(IN8),
	.inp1(IN9),
	.inp2(INA),
	.inp3(INB),
	.sel(SEL[1:0]),
	.out(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst.W = 32;


mux_4x1	b2v_inst2(
	.inp0(INC),
	.inp1(IND),
	.inp2(INE),
	.inp3(INF),
	.sel(SEL[1:0]),
	.out(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst2.W = 32;


mux_4x1	b2v_inst3(
	.inp0(IN4),
	.inp1(IN5),
	.inp2(IN6),
	.inp3(IN7),
	.sel(SEL[1:0]),
	.out(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst3.W = 32;


mux_4x1	b2v_inst4(
	.inp0(IN0),
	.inp1(IN1),
	.inp2(IN2),
	.inp3(IN3),
	.sel(SEL[1:0]),
	.out(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst4.W = 32;


mux_4x1	b2v_inst5(
	.inp0(SYNTHESIZED_WIRE_0),
	.inp1(SYNTHESIZED_WIRE_1),
	.inp2(SYNTHESIZED_WIRE_2),
	.inp3(SYNTHESIZED_WIRE_3),
	.sel(SEL[3:2]),
	.out(OUT));
	defparam	b2v_inst5.W = 32;


endmodule
/* 16x1 MUX*/