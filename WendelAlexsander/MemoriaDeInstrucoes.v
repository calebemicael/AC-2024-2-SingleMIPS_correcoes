module MemoriaDeInstrucoes(
    input wire [31:0] address,      // Endereço da instrução
    output wire [31:0] instruction // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];


    // Leitura combinacional
    assign instrucao = memoria[address[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
