module Mux #(parameter WIDTH = 32)( 
    input wire [WIDTH - 1:0] A,
    input wire [WIDTH - 1:0] B,
    input wire sel,
    output wire [WIDTH - 1:0] out
);

    assign out = (sel) ? B : A;

endmodule