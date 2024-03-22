`timescale 1ns/1ns
`include "ImmGen.v"

module ImmGen_tb;

	reg [31:0] Instruction;
	wire [31:0] Immediate;

	ImmGen dut (
		.Instruction_i (Instruction),
		.Immediate_o (Immediate)
	);

	initial begin 

		$dumpfile ("ImmGen_tb.vcd");
		$dumpvars (0, ImmGen_tb);

		//R-type
		Instruction =32'b00000000001000001000000000110011 ; // add x0, x1, x2
		#20;
		$display("Immediate = %b or %d, expected Immediate: don't care ", Immediate, Immediate);

		//I-type 2
		Instruction =32'b00000001000100001000000000010011 ; // addi x0, x1, 17
	      	#10;
		$display("Immediate = %b or %d, expected Immediate: 17 ", Immediate, Immediate);		

		Instruction =32'b11111110111100001000000000010011 ; // addi x0, x1,-17
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: -17 ", Immediate, Immediate);

		// I-type 1
		Instruction =32'b00000001100100001010000000000011 ; // lw x0, 25(x1) 
	      	#10;
		$display("Immediate = %b or %d, expected Immediate: 25 ", Immediate, Immediate);

		Instruction =32'b11111110011100001010000000000011 ; // lw x0, -25(x1) 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: -25 ", Immediate, Immediate);


		//I-type3
		Instruction =32'b00001111010100000000000011100111 ; // jalr x1, 245(x0) 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: 245  ", Immediate, Immediate);

		Instruction =32'b11110000101100000000000011100111 ; // jalr x1, -245(x0) 
	      	#10;
		$display("Immediate = %b or %d, expected Immediate: -245 ", Immediate, Immediate);

		//S-type
		Instruction =32'b01111110001011111010111110100011 ; // sw x2, 2047(x31) 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: 2047 ", Immediate, Immediate);

		Instruction =32'b10000000001011111010000010100011 ; // sw x2, -2047(x31) 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: -2047: ", Immediate, Immediate);

		//SB-type
		Instruction =32'b00000000000100000000100101100011 ; // beq x0, x1, 18 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: 18  ", Immediate, Immediate);

		Instruction =32'b11111110000100000000011111100011 ; // beq x0, x1, -18 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: -18 ", Immediate, Immediate);

		//U-type
		Instruction =32'b00000000000000110111000010110111 ; // lui x1, 55 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: 225280  ", Immediate, Immediate);

		Instruction =32'b11111111111111001001000010110111 ; // lui x1, -55 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: -225280 ", Immediate, Immediate);


		//UJ-type
		Instruction =32'b00000001010000000000000001101111 ; // jal x0, 20 
	      	#20;
		$display("Immediate = %b or %d, expected Immediate: 20 ", Immediate, Immediate);

		Instruction =32'b11111110110111111111000001101111 ; // jal x0, -20 
	      	#10;
		$display("Immediate = %b or %d, expected Immediate: -20 ", Immediate, Immediate);



	end	


endmodule 
