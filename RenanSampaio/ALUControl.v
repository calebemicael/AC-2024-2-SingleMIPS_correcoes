module ALUControl(
    input wire [1:0] ALUOp,      // Sinal ALUOp da Unidade de Controle
    input wire [5:0] funct,      // Campo "funct" da instrução
    output reg [3:0] ALUControl  // Sinal de controle para a ALU
);

    // Decodificação do sinal de controle para a ALU
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010; // Operação de soma (e.g., lw, sw)
            2'b01: ALUControl = 4'b0110; // Operação de subtração (e.g., branch)
            2'b10: begin
                // Para instruções do tipo R, decodifica o campo "funct"
                case (funct)
                    6'b100000: ALUControl = 4'b0010; // ADD
                    6'b100010: ALUControl = 4'b0110; // SUB
                    6'b100100: ALUControl = 4'b0000; // AND
                    6'b100101: ALUControl = 4'b0001; // OR
                    6'b101010: ALUControl = 4'b0111; // SLT
                    default:   ALUControl = 4'bxxxx; // Operação inválida
                endcase
            end
            default: ALUControl = 4'bxxxx; // Operação inválida
        endcase
    end
endmodule
