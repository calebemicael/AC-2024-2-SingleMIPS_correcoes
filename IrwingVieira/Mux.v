//Ideia de usar um mux básico para entradas de 32 bits.
module Mux(
    input [31:0] entradaA,
    input [31:0] entradaB,
    input seletora,
    output [31:0] saida
);

    assign saida = (seletora) ? entradaA : entradaB; //Uso do operador ternário: se seletora for 1, então é entradaA. Se 0, então entradaB.
endmodule