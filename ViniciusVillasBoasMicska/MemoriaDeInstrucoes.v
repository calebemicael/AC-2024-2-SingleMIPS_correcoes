module MemoriaDeInstrucoes(
    input wire [31:0] addr,        // Endereço da instrução
    output wire [31:0] instrucao   // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [0:255];

    initial begin
        $readmemb("teste3.bin", memoria); 
    end

    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para alinhamento em palavras
endmodule

