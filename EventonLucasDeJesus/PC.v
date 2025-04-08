// Módulo do Contador de Programa (PC)
module PC (clk, reset, pc_in, pc_out);
    input clk, reset;
    input [31:0] pc_in;
    output reg [31:0] pc_out;

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 0;      // Reseta o PC para 0
        else
            pc_out <= pc_in;  // Atualiza o PC com o próximo endereço
    end
endmodule
