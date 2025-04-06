// PC (Program Counter) - Contador de Programa
module PC(
    input clk,                   // Sinal de clock
    input rst,                   // Sinal de reset
    input [31:0] next_pc,        // Próximo valor do PC (endereço da próxima instrução)
    output reg [31:0] pc         // Valor atual do PC (endereço da instrução atual)
);
    always @(posedge clk, posedge rst) begin
        if (rst)
            pc <= 32'b0; // Se o reset estiver ativo, o PC é definido como 0 (reinicialização do processador)
        else
            pc <= next_pc; // Caso contrário, o PC recebe o próximo endereço de instrução
    end
endmodule
