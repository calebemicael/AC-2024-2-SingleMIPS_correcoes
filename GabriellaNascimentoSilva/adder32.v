// Módulo adder32 - Somador de 32 bits
module adder32(
    input wire [31:0] a,           // Operando a
    input wire [31:0] b,           // Operando b
    output wire [31:0] sum         // Resultado da soma
);

    assign sum = a + b;            // Soma a + b
endmodule
