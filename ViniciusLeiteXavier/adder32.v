module adder32(
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] sum
);

    assign sum = a + b;

endmodule