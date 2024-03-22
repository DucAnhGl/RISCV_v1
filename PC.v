module PC (
	input clk,
	input [31:0] NextAddr,
	output reg [31:0] CurrentAddr
);

always @(posedge clk) begin
	CurrentAddr <= NextAddr;
end

endmodule
