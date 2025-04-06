module Mux2pra1(
    input wire [31:0] in0,    // Entrada 0
    input wire [31:0] in1,    // Entrada 1
    input wire seletor,       // Seletor
    output wire [31:0] out    // Saída
);

    assign out = (seletor) ? in1 : in0;  // Seleciona in0 se seletor = 0 e seleciona in1 se seletor = 1

endmodule