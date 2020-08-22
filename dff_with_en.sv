module dff_en #(parameter W = 8) (clk, reset, en, d, q);
	input logic clk, reset, en;
	input logic [W-1:0] d ;
	output logic [W-1:0] q ;

	always_ff @(posedge clk, posedge reset)
		if (reset) q <= 0;
		else if (en) q <= d;
endmodule 