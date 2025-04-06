module Concat(
    input wire[27:0] A,
    input wire[3:0] B,
    output wire[31:0] out
);

assign out[27:0] = A;
assign out[31:28] = B;

endmodule