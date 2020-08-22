module alu_arm (Src_A, Src_B, ALU_Control,N,Z,C,V, ALU_Result);
	input logic signed  [15:0] Src_A, Src_B;
	input logic [2:0] ALU_Control;
	output logic [15:0] ALU_Result;
	output logic N,Z,C,V ;
	
	

	always_comb
		begin
		case(ALU_Control)
			3'b000:
			begin 
				{C,ALU_Result} = Src_A + Src_B ;   //ADD
				if (Src_A[15] ~^ Src_B[15])
					V = ALU_Result[15] ^ Src_A[15];
				else
					V = 0;        //Overflow Add
			end	
			3'b001:
			begin 
				{C,ALU_Result} = Src_A - Src_B ;   //SUB
				if (Src_A[15] ^ Src_B[15])
					V = ALU_Result[15] ^ Src_A[15];
				else
					V = 0;        //Overflow Sub

			end
			3'b010:
			begin 
				ALU_Result = Src_A & Src_B ;       //AND
 				C = 0;
				V = 0;
			end
			3'b011:
			begin 
				ALU_Result = Src_A | Src_B ;       //OR
				C = 0;
				V = 0;
			end 
			3'b100:
			begin 
				ALU_Result = Src_A ^ Src_B ;       //XOR
				C = 0;
				V = 0;
			end 
			3'b101:
			begin 
				ALU_Result = 16'h0 ;               //CLR
				C = 0;
				V = 0;
			end 
			default : ALU_Result = Src_B[15:0];   //Can be used for transfer from ALU
      endcase
		
		N = ALU_Result[15]			  ;
		Z = (ALU_Result == {16{1'b0}}) ;
		end
		
endmodule
	