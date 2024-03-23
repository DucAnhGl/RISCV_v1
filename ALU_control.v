module ALU_control (
	input [1:0] ALUOp_i,
	input [2:0] Funct3_i,
	input [6:0] Funct7_i,
	
	output reg [3:0] ALUCtrl_o
);

	always @(*) begin
		case (AlUOp_i)
			2'b00: begin
				ALUCtrl_o = ((Funct3_i==3'b000)&&(Funct7_i==7'b0000000)) ? 4'b0000 :
					    ((Funct3_i==3'b000)&&(Funct7_i==7'b0100000)) ? 4'b0000 :
			end
		endcase
	end

endmodule
