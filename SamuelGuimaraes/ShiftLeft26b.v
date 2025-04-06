module ShiftLeft26b(
    input wire [25:0] in,          // Entrada de 32 bits
    output wire [27:0] out         // Saída deslocada
);
    wire [27:0] auxiliar;
    assign auxiliar [27] = 0;
    assign auxiliar [26] = 0;
    assign auxiliar [25:0] = in;

    assign out = auxiliar << 2;          // Desloca à esquerda em 2 bits

endmodule
