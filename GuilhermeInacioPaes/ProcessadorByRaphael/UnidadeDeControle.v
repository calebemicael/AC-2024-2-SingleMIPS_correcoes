module UnidadeDeControle(
    input wire[5:0] OPcode,
    input wire zero,
    output reg RegDst,
    output reg BranchandZero,
    output reg MemRead,
    output reg MemtoReg,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg[1:0] ALUOp,
    output reg Jump
);

always @(*) begin
    case (OPcode)
        6'b000000: begin //case das operações do tipo R
            RegDst = 1;
            BranchandZero = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;
            ALUOp = 2'b10;
            Jump = 0;
        end
        6'b100011: begin // carrega da meeoria para reg
            RegDst = 0;
            BranchandZero= 0;
            MemRead = 1;
            MemtoReg = 1;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b00;
            Jump = 0;
        end
        6'b101011: begin // armazena palavra do reg na memoria
            RegDst = 0;
            BranchandZero=0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 1;
            ALUSrc = 1;
            RegWrite = 0;
            ALUOp = 2'b00;
            Jump = 0;
        end
        6'b000100: begin // operacao beq
            RegDst = 0;
            BranchandZero=zero;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            ALUOp = 2'b01;
            Jump = 0;
        end
        6'b000010: begin //operacao de jump
            RegDst = 0;
            BranchandZero=0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            ALUOp = 2'b00;
            Jump = 1;
        end
        default: begin // caso não seja operação não definida na tabela
            RegDst = 0;
            BranchandZero=0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            ALUOp = 2'b00;
            Jump = 0;
        end
    endcase
end

endmodule