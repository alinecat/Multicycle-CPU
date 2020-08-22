module register_file(CLK, WE, RA1, RA2, WA3, WD3,RD1, RD2);
	input logic CLK,WE;
	input logic [2:0] RA1,RA2,WA3;
	input logic [15:0] WD3;
	output logic [15:0] RD1, RD2 ;
	

	
	reg [15:0] regf [7:0];


	initial begin
		regf[0] = 16'h0000 ;
		regf[1] = 16'h0000 ;
		regf[2] = 16'h0000 ;
		regf[3] = 16'h0000 ;
		regf[4] = 16'h0000 ;
		regf[5] = 16'h0000 ;
		regf[6] = 16'h0000 ;
		regf[7] = 16'h0000 ;
	end
	
	
	always @(posedge CLK)
		if (WE) regf[WA3] <= WD3;
		
		
	assign RD1 = regf[RA1] ;
	assign RD2 = regf[RA2] ;
		
endmodule
	
          