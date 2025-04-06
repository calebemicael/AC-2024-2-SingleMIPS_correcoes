module UnidadeControle (
    input wire [5:0] opcode,
    output reg RegWrite, MemRead, MemWrite, ALUSrc, Branch, RegDst, MemtoReg,
    output reg [1:0] ALUOp
);
    always @(*) begin
    // Valores padrão para evitar comportamento inesperado
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        ALUSrc = 0;
        ALUOp = 2'b00;
        Branch = 0;
        RegDst = 0;
        MemtoReg = 0;

        case (opcode)
            6'b000000: begin  // **Tipo R**
                RegWrite = 1;
                ALUOp = 2'b10;
                RegDst = 1;
                MemtoReg = 0;
            end

            6'b100011: begin  // **LW**
                RegWrite = 1;
                MemRead = 1;
                ALUSrc = 1;
                RegDst = 0;
                MemtoReg = 1;
            end

            6'b101011: begin  // **SW**
                MemWrite = 1;
                ALUSrc = 1;
                MemtoReg = 0;
            end

            6'b000100: begin  // **BEQ**
                ALUOp = 2'b01;
                Branch = 1;
                MemtoReg = 0;
            end

            6'b001000: begin  // **ADDI**
                RegWrite = 1;
                ALUSrc = 1;
                RegDst = 0;
                ALUOp = 2'b00; // ADD imediato
                MemtoReg = 0;
            end
            default: begin
                RegWrite = 0;  // Garante que NOP não escreve
                MemtoReg = 0;
            end
        endcase
    end
endmodule