`include "InstructionMemory.v"
`include "Add4.v"
module FetchUnit(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    input wire [31:0] nextInstruction,
    output wire [31:0] instruction,    // Instrução buscada da memória
    output wire [31:0] incrementedPc
);

    // Registrador do PC
    reg [31:0] pc;

    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(incrementedPc)
    );

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    InstructionMemory memory (
        .addr(pc),
        .instruction(instruction)
    );

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            pc <= nextInstruction;  
        end
    end

endmodule
