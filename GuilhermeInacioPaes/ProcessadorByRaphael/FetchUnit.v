module FetchUnit(
    input wire clk,                 
    input wire reset,               
    input wire[31:0] proxInstrucao,  //resultado do desvio
    output wire[31:0] instrucao,    // Instrução vinda da memoria de instrucao
    output wire[31:0] pcPlus4 // proxima instrucao sequencial pc+4
);

    // contador de programa
    reg [31:0] pc;

    //endereco da proxima instrucao sequencial. 
    assign pcPlus4 = pc + 4;

    // intandia do módulo para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(pc),
        .instrucao(instrucao)
    );

    // Lógica de atualização do PC
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o pc no reset
            pc <= 32'b0;
        end else begin
            // atualiza valor do pc
            pc <= proxInstrucao;
        end
    end

endmodule