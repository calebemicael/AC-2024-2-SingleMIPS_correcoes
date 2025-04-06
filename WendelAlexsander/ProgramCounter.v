// PC (Program Counter) - Contador de Programa
module PogramCounter(
    input clk,                   // Sinal de clock
    input rst,                   // Sinal de reset
    input [31:0] next_instruction,        // Próximo valor da próxima isntrução
    output reg [31:0] pc         // Valor do endereço da nistrução atual
);
    always @(posedge clk, posedge rst) begin
        if (rst)
            pc <= 32'b0; // Se o rst for 1, o PC é definido como 0 (reiniciado)
        else
            pc <= next_pc; // Senão, o PC recebe o próximo endereço
    end
endmodule