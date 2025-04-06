module ALUControl (
    input wire [1:0] ALUOp,       // Sinal da Unidade de Controle
    input wire [5:0] funct,       // Campo "funct" da instrução Tipo R
    output reg [3:0] ALUControlSignal // Código da operação para a ALU
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControlSignal = 4'b0010; // LW e SW → Soma (ADD)
            2'b01: ALUControlSignal = 4'b0110; // BEQ → Subtração (SUB)
            2'b10: begin // Tipo R, define pela função (funct)
                case (funct)
                    6'b100000: ALUControlSignal = 4'b0010; // ADD
                    6'b100010: ALUControlSignal = 4'b0110; // SUB
                    6'b100100: ALUControlSignal = 4'b0000; // AND
                    6'b100101: ALUControlSignal = 4'b0001; // OR
                    6'b101010: ALUControlSignal = 4'b0111; // SLT (Set on Less Than)
                    default:   ALUControlSignal = 4'bxxxx; // Instrução Inválida
                endcase
            end
            default: ALUControlSignal = 4'bxxxx; // Instrução Inválida
        endcase
    end
endmodule
