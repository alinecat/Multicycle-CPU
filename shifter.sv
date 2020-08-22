module shifter(sh, imm, inp, out);

	input logic signed  [15:0] inp ;
	input logic [3:0] imm  ;
	input logic [2:0] sh   ;
	output logic signed  [15:0] out ;

	
	
	always_comb
	begin
		out = 16'h0000;
		case(sh)
		3'b001: //rotate right, deode according to the cases.
		begin
			case(imm)
			0:
			begin
			out = inp;
			end
			1:
			begin
			out = {inp[0], inp[15:1]};
			end
			2:
			begin
			out = {inp[1:0], inp[15:2]};
			end
			3:
			begin
			out = {inp[2:0], inp[15:3]};
			end
			4:
			begin
			out = {inp[3:0], inp[15:4]};
			end
			5:
			begin
			out = {inp[4:0], inp[15:5]};
			end
			6:
			begin
			out = {inp[5:0], inp[15:6]};
			end
			7:
			begin
			out = {inp[6:0], inp[15:7]};
			end
			8:
			begin
			out = {inp[7:0], inp[15:8]};
			end
			9:
			begin
			out = {inp[8:0], inp[15:9]};
			end
			10:
			begin
			out = {inp[9:0], inp[15:10]};
			end
			11:
			begin
			out = {inp[10:0], inp[15:11]};
			end
			12:
			begin
			out = {inp[11:0], inp[15:12]};
			end
			13:
			begin
			out = {inp[12:0], inp[15:13]};
			end
			14:
			begin
			out = {inp[13:0], inp[15:14]};
			end
			15:
			begin
			out = {inp[14:0], inp[15]};
			end
			default:
			begin
			out = 16'hxxxx;
			end
			endcase
		end	
		3'b000: //rotate left
		begin
			case(imm)
			4'h0:
			begin
			out = inp;
			end
			4'h1:
			begin
			out = {inp[14:0], inp[15:15]};
			end
			4'h2:
			begin
			out = {inp[13:0], inp[15:14]};
			end
			4'h3:
			begin
			out = {inp[12:0], inp[15:13]};
			end
			4'h4:
			begin
			out = {inp[11:0], inp[15:12]};
			end
			4'h5:
			begin
			out = {inp[10:0], inp[15:11]};
			end
			4'h6:
			begin
			out = {inp[9:0], inp[15:10]};
			end
			4'h7:
			begin
			out = {inp[8:0], inp[15:9]};
			end
			4'h8:
			begin
			out = {inp[7:0], inp[15:8]};
			end
			4'h9:
			begin
			out = {inp[6:0], inp[15:7]};
			end
			4'hA:
			begin
			out = {inp[5:0], inp[15:6]};
			end
			4'hB:
			begin
			out = {inp[4:0], inp[15:5]};
			end
			4'hC:
			begin
			out = {inp[3:0], inp[15:4]};
			end
			4'hD:
			begin
			out = {inp[2:0], inp[15:3]};
			end
			4'hE:
			begin
			out = {inp[1:0], inp[15:2]};
			end
			4'hF:
			begin
			out = {inp[0], inp[15:1]};
			end
			default:
			begin
			out = 16'hxxxx;
			end
			endcase
		end	
		3'b010: //logical shift left
		begin
			out = inp << imm ; 
		end
		3'b011: //arithmetic shift right
		begin
			out = inp >>> imm ; 
		end
		3'b100: //logical shift right
		begin
			out = inp >> imm ; 
		end
		default: 
		begin
			out = 16'hFFFF ;
		end
		endcase
	end
		
		
			
endmodule

