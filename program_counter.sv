module pc(PC_IN, PC_OUT, CLK, PC_en, RST);

	input  logic [15:0]  PC_IN;
	input  logic RST, PC_en, CLK;
	output logic [15:0] PC_OUT;
	
	initial 
		PC_OUT = 16'h0010; //instructions stars after reseved memory
								 //first 16 addresses are used for indirect addressing modes. 
	
	always @(posedge CLK)
	begin	
		if (RST == 1'b1)
			PC_OUT <= 16'h0010 ;
		else if (PC_en == 1'b1)
			PC_OUT <= PC_IN ;
	end
	
endmodule
	