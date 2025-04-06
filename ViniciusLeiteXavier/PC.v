module pc (
    input wire clk,         // Clock
    input wire reset,       // Sinal de reset
    input wire [31:0] next_pc, // Próximo endereço da instrução
    output reg [31:0] pc    // Endereço atual da instrução
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;  // Se reset, inicia o PC em 0
        else
            pc <= next_pc; // Atualiza o PC com o próximo endereço
    end

endmodule