module FetchUnit (
    input clk,
    input reset,
    input Branch,
    input zero,
    input [31:0] offset,
    output reg [31:0] instrucao
);

    reg [31:0] PC;  // Contador de programa
    wire [31:0] instrucao_memoria;  // Instrução vinda da memória de instruções
    reg [31:0] nextPC;

    // Instância da memória de instruções
    MemoriaDeInstrucoes memoria_instrucoes (
        .addr(PC),       // Passa o valor do PC para a memória
        .instrucao(instrucao_memoria)  // Recebe a instrução
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 0;  // Reset PC para 0
        end
        else begin
            PC <= nextPC;  // Atualiza o PC depois de buscar a instrução
        end
    end

    always @(*) begin
        // Calcula o próximo PC baseado na condição de branch
        nextPC = (Branch & zero) ? (PC + 4 + offset) : (PC + 4);
    end

    always @(posedge clk) begin
        instrucao <= instrucao_memoria;  // Busca a instrução com o PC atual antes do próximo ciclo
    end

endmodule
