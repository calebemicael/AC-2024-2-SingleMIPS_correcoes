module ControlUnit (
    input wire [5:0] opcode,
    output wire RegWrite,
    output wire ALUSrc,
    output wire MemRead,
    output wire MemWrite,
    output wire Branch,
    output wire Jump,
    output wire MemToReg,
    output wire RegDst,
    output wire [3:0] ALUOperation
);

    always @(*) begin
        case (opcode)
            6'b000000: begin  // R-type
                RegWrite = 1;
                ALUSrc = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                MemToReg = 0;
                RegDst = 1;
                ALUOperation = 4'b0010;  // Soma
            end
            6'b100011: begin // lw
                RegWrite = 1;
                ALUSrc = 1;
                MemWrite = 0;
                MemRead = 1;
                Branch = 0;
                Jump = 0;
                MemToReg = 1;
                RegDst = 0;
                ALUOperation = 4'b0010; // Soma (para calcular o endereço)
            end
            6'b101011: begin // sw
                RegWrite = 0;
                ALUSrc = 1;
                MemWrite = 1;
                MemRead = 0;
                Branch = 0;
                Jump = 0;
                MemToReg = 0;
                RegDst = 0;
                ALUOperation = 4'b0010; // Soma (para calcular o endereço)
            end
            6'b000100: begin // beq
                RegWrite = 0;
                ALUSrc = 0;
                MemWrite = 0;
                MemRead = 0;
                Branch = 1;
                Jump = 0;
                MemToReg = 0;
                RegDst = 0;
                ALUOperation = 4'b0110; // Subtração (para comparar)
            end
            6'b000010: begin // j
                RegWrite = 0;
                ALUSrc = 0;
                MemWrite = 0;
                MemRead = 0;
                Branch = 0;
                Jump = 1;
                MemToReg = 0;
                RegDst = 0;
                ALUOperation = 4'b0000; // Não importa
            end
            default: begin // Instrução inválida
                RegWrite = 0;
                ALUSrc = 0;
                MemWrite = 0;
                MemRead = 0;
                Branch = 0;
                Jump = 0;
                MemToReg = 0;
                RegDst = 0;
                ALUOperation = 4'b0000;
            end
        endcase
    end
endmodule