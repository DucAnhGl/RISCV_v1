`timescale 1ns/1ns
`include "ALU_and_ALU_control.v"


module ALU_and_ALU_control_tb;

	reg [2:0] Funct3_i; // For ALU and ALU_control
	reg [6:0] Funct7_i; // For ALU_control

	reg [31:0] OperandA_i, OperandB_i; // For ALU
        reg [1:0] ALUOp_i; // For ALU_control

	wire [31:0] Result_o;
	wire Flag_o;	

	ALU_and_ALU_control dut (
		.Funct3_i (Funct3_i),
		.Funct7_i (Funct7_i),
		.ALUOp_i (ALUOp_i),
		.OperandA_i (OperandA_i),
		.OperandB_i (OperandB_i),
		.Result_o (Result_o),
		.Flag_o (Flag_o)
	);

	initial begin 
		
		$dumpfile("ALU_and_ALU_control_tb.vcd");
		$dumpvars(0, ALU_and_ALU_control_tb);


		$display("Arithmetic-Logic Operations:");
		OperandA_i=20; OperandB_i=30; Funct3_i=3'b000; Funct7_i=7'b0000000; ALUOp_i=2'b00; // Add
		#20;
		display;

		OperandA_i=20; OperandB_i=30; Funct3_i=3'b000; Funct7_i=7'b0100000; ALUOp_i=2'b00; // Sub
		#20;
		display;

		OperandA_i=5; OperandB_i=2; Funct3_i=3'b001; Funct7_i=7'b0000000; ALUOp_i=2'b00;   // Sll 
		#20;
		display;

		OperandA_i=3; OperandB_i=5; Funct3_i=3'b100; Funct7_i=7'b0000000; ALUOp_i=2'b00;   // Xor 
		#20;
		display;

		OperandA_i=20; OperandB_i=2; Funct3_i=3'b101; Funct7_i=7'b0000000; ALUOp_i=2'b00;  // Srl
		#20;
		display;

		OperandA_i=-20; OperandB_i=2; Funct3_i=3'b101; Funct7_i=7'b0100000; ALUOp_i=2'b00; // Sra
		#20;
		display;

		OperandA_i=8; OperandB_i=5; Funct3_i=3'b110; Funct7_i=7'b0000000; ALUOp_i=2'b00;   // Or
		#20;
		display;

		OperandA_i=8; OperandB_i=5; Funct3_i=3'b111; Funct7_i=7'b0000000; ALUOp_i=2'b00;   // And 
		#20;
		display;

		// Load-Store
		$display("");
		$display("Load-Store:");
		OperandA_i=20; OperandB_i=30; Funct3_i=3'b000; Funct7_i=7'b0000000; ALUOp_i=2'b01; // Load-Store
		#20;
		display;

		// Conditional Branch
		$display("");
		$display("Conditional Branch:");
		OperandA_i=20; OperandB_i=20; Funct3_i=3'b000; Funct7_i=7'b0000000; ALUOp_i=2'b10; // BEQ (Condition true case)
		#20;
		display;

		OperandA_i=20; OperandB_i=20; Funct3_i=3'b000; Funct7_i=7'b0000000; ALUOp_i=2'b10; // BEQ (Condition false case) 
		#20;
		display;

		// LUI
		$display("");
		$display("Load upper immediate:");
		OperandA_i=30; OperandB_i=5; Funct3_i=3'b100; Funct7_i=7'b0000000; ALUOp_i=2'b11;   // LUI 
		#20;
		display;


	end

		task display;
			$display("OperandA= %d, OperandB= %d, Funct3= %b, Funct7= %b, ALUOp= %b, Result= %d, Flag= %b",
			$signed(OperandA_i),$signed(OperandB_i), Funct3_i, Funct7_i, ALUOp_i, $signed(Result_o), Flag_o);
		endtask	

endmodule 
