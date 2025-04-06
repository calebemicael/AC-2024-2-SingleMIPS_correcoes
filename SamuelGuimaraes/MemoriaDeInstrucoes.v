module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    integer i;
    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];

    // Inicialização da memória com algumas instruções
    initial begin
        $readmemh("codigo.mem", memoria);
    end

    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
