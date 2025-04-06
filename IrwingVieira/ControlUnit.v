module ControlUnit(//Controla o fluxo dos sinais para os demais operadores:
    input [5:0] opCode,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg ALUOp1,
    output reg ALUOp0,
    output reg jump
);

    always @(*) begin
        case (opCode)
            6'b000000: begin // R-Format.
                RegDst = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp1 = 1;
                ALUOp0 = 0;
                jump = 0;
            end

            6'b001000: begin // Operador do tipo I para addi.
                RegDst = 0;
                ALUSrc = 1;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp1 = 0;
                ALUOp0 = 0;
                jump = 0;
            end

            6'b000010: begin // Jump.
                RegDst = 0; // Don't care
                ALUSrc = 0; // Don't care
                MemtoReg = 0; // Don't care
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp1 = 0; // Don't care
                ALUOp0 = 0; // Don't care
                jump = 1;
            end

            6'b100011: begin // Load word.
                RegDst = 0;
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp1 = 0;
                ALUOp0 = 0;
                jump = 0;
            end

            6'b101011: begin // Store word.
                RegDst = 1; // Don't care
                ALUSrc = 1;
                MemtoReg = 1; // Don't care
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp1 = 0;
                ALUOp0 = 0;
                jump = 0;
            end

            6'b000100: begin // BEQ (branch if equal).
                RegDst = 1; // Don't care
                ALUSrc = 0;
                MemtoReg = 1; // Don't care
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp1 = 0;
                ALUOp0 = 1;
                jump = 0;
            end

            default: begin
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp1 = 0;
                ALUOp0 = 0;
                jump = 0;
            end
        endcase
    end

endmodule