module sll2 (entrada, saida);
    input [31:0] entrada;
    output [31:0] saida; 

    assign saida = entarda << 2; //faz um shift left de 2bits 

endmodule