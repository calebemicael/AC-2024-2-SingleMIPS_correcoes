//Ideia de usar um mux básico para entradas de 5 bits.
//Aqui será feita a transferência dos bits para o rt ou rd, com base na entrada seletora.
module Mux5bits(
    input [4:0] entradaA,
    input [4:0] entradaB,
    input seletora,
    output [4:0] saida
);

    assign saida = (seletora) ? entradaA : entradaB; //Uso do operador ternário: se seletora for 1, então é entradaA. Se 0, então entradaB.
endmodule