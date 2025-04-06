module Mux2pra1com5b(
    input wire [4:0] in0,    // Entrada 0
    input wire [4:0] in1,    // Entrada 1
    input wire seletor,       // Seletor
    output wire [4:0] out    // Saída
);

    assign out = (seletor) ? in1 : in0;  // Seleciona in0 se seletor = 0 e seleciona in1 se seletor = 1

endmodule