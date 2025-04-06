module Mux5(
    input wire [4:0] A,
    input wire [4:0] B,
    input wire sel,
    output wire [4:0] result
);

    assign result = sel ? A : B;
endmodule