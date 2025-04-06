module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];

    // Inicialização da memória
    integer i;
    initial begin
        // Garante que a memória está zerada antes de carregar as instruções
        for (i = 0; i < 256; i = i + 1) begin
            memoria[i] = 32'b0;
        end
        // Lê o arquivo com instruções
        $readmemb("instrucoes.mem", memoria);
    end
    
    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
