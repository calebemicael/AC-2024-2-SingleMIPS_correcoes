module PC(
    input wire clk,
    input wire reset,
    input wire [31:0] nextPc,  // Endereço da próxima instrução
    output reg [31:0] pc       // Endereço atual
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0;  // Inicializa o PC com 0 em caso de reset
        end else begin
            pc <= nextPc; // Atualiza o PC com o próximo endereço
        end
    end

endmodule
