module ALU(
    input wire [31:0] operand1,           // Operando 1
    input wire [31:0]operand2,           // Operando 2
    input wire [3:0] ALUoperation, // Código da operação ALU
    output reg [31:0] ALUresult,   // Resultado da ALU
    output wire zero               // Sinal zero (ativo quando ALUresult é 0)
);

    // Define o comportamento da ALU
    always @(*) begin
        casez (ALUoperation)
            4'b0000: ALUresult = operand1 & operand2;          // AND
            4'b0001: ALUresult = operand1 | operand2;          // OR
            4'b0010: ALUresult = operand1 + operand2;          // Soma
            4'b0110: ALUresult = operand1 - operand2;          // Subtração
            4'b0111: ALUresult = (operand1 < operand2) ? 1 : 0; // SLT (Set Less Than)
            4'b1100: ALUresult = ~(operand1 | operand2);       // NOR
            default: ALUresult = 32'b0;          // Operação inválida
        endcase
    end

    // Define o sinal zero
    assign zero = (ALUresult == 32'b0) ? 1'b1 : 1'b0;

endmodule
