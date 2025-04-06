module InstructionMemory(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [0:255]; //Professor, fiz essa mudança pq o meu compilador estava reclamando.

    // Inicialização da memória com algumas instruções para fins de teste:
    initial begin 
        $readmemb("instrucoes.mem", memoria); // Carrega o arquivo .hex na memória
    end

    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
