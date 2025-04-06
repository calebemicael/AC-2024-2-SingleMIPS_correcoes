module MUX2to1_ALUSrc(
    input wire [31:0] ReadData2,   // Dado do segundo operando da ALU (registrador)
    input wire [31:0] Immediate,    // Imediato
    input wire ALUSrc,              // Controle de seleção
    output wire [31:0] ALUInput2    // Saída para o segundo operando da ALU
);

    assign ALUInput2 = (ALUSrc) ? Immediate : ReadData2; // Se ALUSrc for 1, usa o imediato

endmodule