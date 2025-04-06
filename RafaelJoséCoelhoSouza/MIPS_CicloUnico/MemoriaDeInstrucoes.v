module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];


    initial begin
        $readmemb("codigo.mem", memoria);
    end

    // endereço do PC vai de 4 em 4.
    // Logo a cada instrução soma '100' - shift left 2!
    // Assim vamos indexar a memória a partir do 3° LSB.

    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
