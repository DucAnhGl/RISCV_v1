module ALU (
	input [31:0] OperandA_i,
	input [31:0] OperandB_i,

	input [3:0] ALUCtrl_i,
	input [2:0] Flagsel_i,	// Comes from ALU_Control block or comes from funct3
       				// If comes from funct3 then: 

	output reg Result_o,
	output reg Flag_o	
);

	parameter EQ_para	= 000,
		  NE_para	= 001,
	  	  LT_para	= 010,
		  GE_para	= 011,
		  LTU_para	= 100,
		  GEU_para	= 101;	  

	reg EQ, NE, LT, GE, LTU, GEU;

	always @(*) begin
		case (ALUCtrl_i)
			4'b0000: Result_o = OperandA_i	+	OperandB_i;
			4'b0001: begin
		       		Result_o = OperandA_i	-	OperandB_i;
				EQ       = (OperandA_i == OperandB_i) ? 1'b1 : 1'b0;
				NE	 = (OperandA_i == OperandB_i) ? 1'b0 : 1'b1;
				LT	 = ($signed(OperandA_i) < $signed(OperandB_i)) ? 1'b1 : 1'b0;
				GE	 = ($signed(OperandA_i) >= $signed(OperandB_i)) ? 1'b1 : 1'b0;
				LTU	 = (OperandA_i < OperandB_i) ? 1'b1 : 1'b0;
				GEU	 = (OperandA_i >= OperandB_i) ? 1'b1 : 1'b0;
			end
			4'b0010: Result_o = OperandA_i	<<	OperandB_i;
		       	4'b0011: Result_o = OperandA_i	^	OperandB_i;
			4'b0100: Result_o = OperandA_i	>>	OperandB_i;
			4'b0101: Result_o = OperandA_i	>>>	OperandB_i;
			4'b0110: Result_o = OperandA_i	|	OperandB_i;
			4'b0111: Result_o = OperandA_i	&	OperandB_i;
			4'b1000: Result_o = OperandB_i	<<	12;
			default: Result_o = 32'h00000000;	
		endcase
		
	end

	always @(*) begin 
		case (Flagsel_i)
			EQ_para	: Flag_o = EQ;
			NE_para	: Flag_o = NE;
			LT_para	: Flag_o = LT;
			GE_para	: Flag_o = GE;
			LTU_para: Flag_o = LTU;
			GEU_para: Flag_o = GEU;
			default: flag_o = 1'b0;			
		endcase
	end

endmodule 
