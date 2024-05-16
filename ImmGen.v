module ImmGen (
	input [31:0] Instruction_i,
       	output reg [31:0] Immediate_o	
);


parameter R_type = 5'b01100,
	  I_type1	 = 5'b00000,
	  I_type2	 = 5'b00100,
	  I_type3	 = 5'b11001,
	  S_type	 = 5'b01000,
	  B_type	 = 5'b11000,
	  U_type	 = 5'b01101,
	  J_type	 = 5'b11011;

//wire opcode [4:0];

//assign opode = Instruction_i[6:2];

always @(*) begin
	case (Instruction_i[6:2])
		R_type : Immediate_o = 32'hxxxxxxxx;

		I_type1 : Immediate_o = { {20{Instruction_i[31]}}, Instruction_i[31:20] };
		I_type2 : Immediate_o = { {20{Instruction_i[31]}}, Instruction_i[31:20] };
		I_type3 : Immediate_o = { {20{Instruction_i[31]}}, Instruction_i[31:20] };

		S_type : Immediate_o = { {20{Instruction_i[31]}}, Instruction_i[31:25], Instruction_i[11:7] };
		B_type : Immediate_o = { {20{Instruction_i[31]}}, Instruction_i[7], Instruction_i[30:25], Instruction_i[11:8], 1'b0 };
		U_type : Immediate_o = { Instruction_i[31:12], 12'b000000000000 };
		J_type : Immediate_o = { {11{Instruction_i[31]}}, Instruction_i[31], Instruction_i[19:12], Instruction_i[20], Instruction_i[30:21], 1'b0 };	
		default: Immediate_o = 32'h00000000;
	endcase

end

endmodule 
