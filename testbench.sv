//Note that control signals are provided with the controller.

module combined_test1_vlg_vec_tst(stop);

output wire stop ;
reg CLK;
reg RST;
                      
combined i1 ( 
	.CLK(CLK),
	.RST(RST)
);



// CLK
always
begin
	CLK = 1'b0;#10
	CLK =  1'b1;#10;
	
end 

// RST
initial
begin
	RST = 1'b1; #10; RST = 1'b0;
end 

assign stop = 1'b0 ;

endmodule