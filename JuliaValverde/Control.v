module Control(
    input wire [5:0] Op,
    output reg RegDst,
    output reg Jump,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg [1:0] ALUOp
);

    always @(*) begin
        case (Op)
            6'b000000: begin //TypeR
                RegDst = 1'b1;
                Jump = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b10;
            end
            6'b001000: begin //TypeI
                RegDst = 1'b0;
                Jump = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            6'b100011: begin //LW
                RegDst = 1'b0;
                Jump = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            6'b101011: begin //SW
                RegDst = 1'b0;
                Jump = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            6'b000100: begin //BEQ
                RegDst = 1'b0;
                Jump = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b1;
                ALUOp = 2'b01;
            end
            6'b000010: begin //Jump
                RegDst = 1'b0;
                Jump = 1'b1;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            default: begin
                RegDst = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
        endcase
    end

endmodule