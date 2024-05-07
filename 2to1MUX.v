module 2to1MUX (
	input [31:0] A_i,
	input [31:0] B_i,
	input sel,
	output reg [31:0] Out_o
);

always @(*) begin
	case (sel):
		1'b0	: Out_o = A_i;
		1'b1	: Out_o = B_i;
		Default : Out_o = 32'h00000000;
	endcase	
end

endmodule
