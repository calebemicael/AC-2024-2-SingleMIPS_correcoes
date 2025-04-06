// Módulo de contagem de programa (Program Counter - PC)
module pc (
    input wire clk,          // Sinal de clock
    input wire reset,        // Reset assíncrono
    input wire [31:0] nextPC, // Próximo valor do PC
    output reg [31:0] pc     // Valor atual do PC
);

    always @(posedge clk or posedge reset) begin
        if (reset) 
            pc <= 32'b0; // Reinicia o PC para 0 no reset
        else 
            pc <= nextPC; // Atualiza o PC com o próximo valor
    end

endmodule
