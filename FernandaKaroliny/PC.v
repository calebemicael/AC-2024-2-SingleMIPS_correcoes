module PC (
    input clk,                          // Clock
    input reset,                        // Sinal de reset
    input [31:0] pc_incrementado,       // Próximo endereço do PC
    output reg [31:0] pc                // Endereço atual do PC
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;  // Inicializa o PC no reset
        else
            pc <= pc_incrementado;       // Atualiza o PC para o próximo endereço
    end

endmodule