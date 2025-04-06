module ula(
    input [3:0] f,         // Código de operação da ULA
    input [31:0] A,        // Primeiro operando
    input [31:0] B,        // Segundo operando
    output reg [31:0] RES  // Resultado da operação
);
    always @(*) begin
        case (f)
            4'b0010: RES = A + B;      // ADD
            4'b0110: RES = A - B;      // SUB
            4'b0000: RES = A & B;      // AND
            4'b0001: RES = A | B;      // OR
            4'b1100: RES = ~(A ^ B);   // XNOR
            4'b1110: RES = ~A;         // NOT A
            4'b1111: RES = ~B;         // NOT B
            4'b1010: RES = A;          // Apenas retorna A sem modificação
            default: RES = 32'b0;      // Caso padrão (zero)
        endcase
    end
endmodule
