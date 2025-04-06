module ALU(
    input [31:0] A,           // Operando A
    input [31:0] B,           // Operando B
    input [3:0] ALU_Control,  // Controle da ALU
    output reg [31:0] Result, // Resultado da operação
    output reg Zero           // Sinal Zero (para BEQ)
);

    always @(*) begin
        
        case (ALU_Control)
            4'b0010: Result = A + B;    // Operação de soma
            4'b0110: Result = A - B;    // Operação de subtração
            4'b0000: Result = A & B;    // Operação AND
            4'b0001: Result = A | B;    // Operação OR
            4'b0111: Result = (A < B) ? 1 : 0;  // SLT
            default: Result = 32'b0;    // Default, pode ser uma operação inválida
        endcase
        
        // Sinal Zero
        Zero = (Result == 32'b0) ? 1 : 0; // Verifica se o resultado é zero
    end
endmodule

