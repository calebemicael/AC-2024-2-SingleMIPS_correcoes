// Shift Left 2
module ShiftLeft2(in, out);
    input [31:0] in;
    output [31:0] out;

    assign out = in << 2;  // Deslocamento lógico para a esquerda por 2 bits
endmodule
