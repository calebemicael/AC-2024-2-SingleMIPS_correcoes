module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];

    integer i;
    // Inicialização da memória a partir de um arquivo externo
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memoria[i] = 32'b0;      // Zera o restante da memória
        end
        $readmemb("instrucoes.bin", memoria); // Carrega instruções em binário
    end

    // Leitura combinacional da instrução
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)

endmodule
