module Mux2para1(
    input wire [31:0] a,    // Primeira entrada
    input wire [31:0] b,    // Segunda entrada 
    input wire sc,         // Sinal de controle (0 ou 1)
    output wire [31:0] out  // Saída
);

    assign out = (sc) ? b : a;

endmodule