// Módulo ALUControl
module aluControl (
    input wire [1:0] aluOp,       // Código de operação vindo da unidade de controle
    input wire [5:0] funct,       // Campo funct da instrução tipo R
    output reg [3:0] aluControl   // Sinal de controle para a ALU
);

    // Definindo a operação da ALU com base no código de operação e funct
    always @(*) begin
        case (aluOp)
            2'b00: aluControl = 4'b0010; // Operações LW e SW (ADD)
            2'b01: aluControl = 4'b0110; // Operação BEQ (SUB)
            2'b10: begin // Operações tipo R (decididas pelo campo funct)
                case (funct)
                    6'b100000: aluControl = 4'b0010; // ADD
                    6'b100010: aluControl = 4'b0110; // SUB
                    6'b100100: aluControl = 4'b0000; // AND
                    6'b100101: aluControl = 4'b0001; // OR
                    6'b101010: aluControl = 4'b0111; // SLT
                    default:   aluControl = 4'bxxxx; // Caso inválido
                endcase
            end
            default: aluControl = 4'bxxxx; // Caso inválido
        endcase
    end

endmodule
