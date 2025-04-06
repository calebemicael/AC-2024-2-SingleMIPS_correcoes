module Add4(
    input wire [31:0] in,
    output wire [31:0] out
);
    assign out = in + 32'd4;
endmodule