module ALUControl (
    input wire [1:0] ALUOp,      // Sinal de controle vindo da Unidade de Controle
    input wire [5:0] funct,      // Campo funct da instrução R-Type
    output reg [3:0] ALUControl  // Sinal de controle da ALU
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010; // LW e SW usam ADD
            2'b01: ALUControl = 4'b0110; // BEQ usa SUB
            2'b10: begin // Tipo R
                case (funct)
                    6'b100000: ALUControl = 4'b0010; // ADD
                    6'b100010: ALUControl = 4'b0110; // SUB
                    6'b100100: ALUControl = 4'b0000; // AND
                    6'b100101: ALUControl = 4'b0001; // OR
                    6'b101010: ALUControl = 4'b0111; // SLT
                    default:   ALUControl = 4'b0000; // Operação inválida
                endcase
            end
            default: ALUControl = 4'b0000; // Caso não definido
        endcase
    end

endmodule
