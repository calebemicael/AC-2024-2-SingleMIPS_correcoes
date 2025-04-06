module Mux32(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire sel,
    output wire [31:0] result
);

    assign result = sel ? A : B;
endmodule