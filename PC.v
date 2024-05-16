module PC (
	input clk,
    input rst,
	input [31:0] NextAddr,
	output reg [31:0] CurrentAddr
);

always @(posedge clk or posedge rst) begin
    if (rst) CurrentAddr <= 32'd0-32'd1;
	else CurrentAddr <= NextAddr;
end

endmodule
