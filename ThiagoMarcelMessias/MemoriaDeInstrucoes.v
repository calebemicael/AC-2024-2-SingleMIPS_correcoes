module MemoriaDeInstrucoes(
    input wire [31:0] addr,        // Endereço da instrução
    output wire [31:0] instrucao   // Instrução lida
);
    // Memória de instruções (1.024 palavras de 32 bits)
    reg [31:0] memoria [0:1023];   // 1.024 palavras de 32 bits

    // Inicialização da memória com o arquivo binário
    initial begin
        $readmemh("codigo.mem", memoria);  // Lê até 1.024 palavras de 32 bits do arquivo hex
    end

    // Leitura combinacional: usa os bits 11 a 2 para acessar a memória
    assign instrucao = memoria[addr[11:2]];  // Acesso à memória com os bits 11 a 2 do endereço
endmodule
