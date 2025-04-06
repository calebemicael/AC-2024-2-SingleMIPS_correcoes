module memoria_instrucoes (
    input [31:0] endereco,   // Endereço da instrução 
    output reg [31:0] instrucao // Instrução lida
);
    // Memória de instruções: 256 palavras de 32 bits
    reg [31:0] mem [0:255];

    // Inicializa a memória com um programa
    initial begin
        
        instrucao = 32'b0;
        $readmemb("instrucoes.mem", mem, 0, 9);
 
    end

    // Leitura da memória (com proteção contra endereços inválidos, fiz isso pq queria 
    //	limitar a qtd de instruções, tive alguns problemas)
    always @(*) begin
        if (endereco[9:2] <= 9)  // Verifica se está dentro dos 10 primeiros endereços
            instrucao = mem[endereco[9:2]];
        else
            instrucao = 32'b0;  // Retorna uma instrução NOP caso o endereço não seja valido
    end
endmodule
