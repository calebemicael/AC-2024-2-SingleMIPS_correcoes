// Somador
module Adder(a, b, result);
    input [31:0] a, b;
    output [31:0] result;

    assign result = a + b;  // Operação de soma
endmodule
