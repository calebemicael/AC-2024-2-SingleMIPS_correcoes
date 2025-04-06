module mux2x1 (
    input [31:0] A,    // Entrada 0 (32 bits fixos)
    input [31:0] B,    // Entrada 1 (32 bits fixos)
    input sel,         // Sinal de seleção
    output [31:0] out  // Saída (32 bits fixos)
);
    // Lógica combinacional direta
    assign out = sel ? B : A;
endmodule