module FetchUnit(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    input wire[31:0] BranchResult,
    output wire[31:0] instrucao,    // Instrução buscada da memória
    output wire[31:0] PcIncrementadoOutput
);

    // Registrador do PC
    reg [31:0] pc;

    // Fios para conexão entre módulos
    //wire [31:0] pc_incrementado;

    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(PcIncrementadoOutput)
    );

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(pc),
        .instrucao(instrucao)
    );

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            pc <= BranchResult;  
        end
    end

endmodule
