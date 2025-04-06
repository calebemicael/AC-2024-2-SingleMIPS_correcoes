module unidade_controle(
    input wire [5:0] opcode,
    input wire [5:0] funct,
    output reg RegWrite,
    output reg [3:0] ALUOperation,
    output reg MemWrite,
    output reg [1:0] pcSrc,
    output reg ALUSrc,
    output reg RegDst
);

    always @(*) begin
        case (opcode)
            6'b000000: begin // Instruções do tipo R
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegDst = 1'b1;
                pcSrc = 2'b00;
                case (funct)
                    6'b100000: ALUOperation = 4'b0010; // ADD
                    6'b100010: ALUOperation = 4'b0110; // SUB
                    6'b100100: ALUOperation = 4'b0000; // AND
                    6'b100101: ALUOperation = 4'b0001; // OR
                    6'b101010: ALUOperation = 4'b0111; // SLT
                    default: ALUOperation = 4'b0000;   // Operação inválida
                endcase
            end
            6'b100011: begin // LW (Load Word)
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                ALUSrc = 1'b1;
                RegDst = 1'b0;
                pcSrc = 2'b00;
                ALUOperation = 4'b0010; // ADD (para calcular o endereço)
            end
            6'b101011: begin // SW (Store Word)
                RegWrite = 1'b0;
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                RegDst = 1'b0;
                pcSrc = 2'b00;
                ALUOperation = 4'b0010; // ADD (para calcular o endereço)
            end
            6'b000100: begin // BEQ (Branch if Equal)
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegDst = 1'b0;
                pcSrc = 2'b01; // Seleciona branchAddress
                ALUOperation = 4'b0110; // SUB (para comparar registradores)
            end
            6'b000010: begin // J (Jump)
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegDst = 1'b0;
                pcSrc = 2'b10; // Seleciona jumpAddress
                ALUOperation = 4'b0000; // Operação irrelevante
            end
            default: begin // Instrução inválida
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegDst = 1'b0;
                pcSrc = 2'b00;
                ALUOperation = 4'b0000;
            end
        endcase
    end

endmodule