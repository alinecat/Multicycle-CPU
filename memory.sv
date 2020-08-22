module memory(CLK, WE, ADDR, WD, RD);

	
	input logic  CLK, WE ;
	input logic [15:0] ADDR, WD ;
	output logic [15:0] RD ;
				

	logic [15:0] RAM[2047:0];    
	
	initial
		$readmemh("new_mem.mif",RAM);
	
	
	assign RD = RAM[ADDR[15:0]]; // word aligned, word addressable

	always_ff @(posedge CLK) 
		if (WE) RAM[ADDR[15:0]] <= WD;
		
		
endmodule