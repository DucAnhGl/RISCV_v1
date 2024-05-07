module WrMemTest;
wire [7:0] Data[0:1];


assign Data[0] = 8'hFF;
assign Data[1] = 8'hAA;

$writememh("Data.mem", Data);

endmodule
