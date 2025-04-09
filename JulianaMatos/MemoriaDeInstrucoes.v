module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];

    // Inicialização da memória com algumas instruções
    integer i;
    initial begin
        memoria[0] = 32'b00111100000000010001000000000001;  //lui $1, 0x1001
        memoria[1] = 32'b10001100001010000000000000000000;  //lw $8, 0($1)
        memoria[2] = 32'b00111100000000010001000000000001;  //lui $1, 0x1001
        memoria[3] = 32'b10001100001010010000000000000100;  //lw $9, 4($1)
        memoria[4] = 32'b00000001000010010101000000100000;  //add $10, $8, $9
        for (i = 5; i < 256; i = i + 1) begin
            memoria[i] = 32'b0;      // Zera o restante da memória
        end
    end

    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
