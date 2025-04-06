module ShiftLeft2J(
    input wire [25:0] in,          //Entrada de 32 bits
    output wire [27:0] out         // entrada deslocada
);

    assign out=in << 2;          //desloca 2 para a esquerda

endmodule
