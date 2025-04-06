module MuxALUSrc(
    input wire [31:0] ReadData2,   // Dado lido do registrador 2
    input wire [31:0] SignExtended, // Valor estendido
    input wire ALUSrc,             // Sinal de controle
    output wire [31:0] ALUInputB   // Entrada B da ALU
);

    assign ALUInputB = (ALUSrc) ? SignExtended : ReadData2;

endmodule