module control_unit(
    input wire [5:0] opcode,
    output reg RegWrite, ALUSrc, MemtoReg, Branch, MemRead, MemWrite,
    output reg [1:0] ALUOp,
    output reg Jump,
    output reg RegDst 
);

    always @(*) begin
        // Valores padrão
        RegWrite = 1'b0;
        ALUSrc   = 1'b0;
        MemtoReg = 1'b0;
        Branch   = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        ALUOp    = 2'b00;
        Jump     = 1'b0;
        RegDst   = 1'b0; 

        case (opcode)
            6'b000000: begin // R
                RegWrite = 1'b1;
                RegDst   = 1'b1; // usa rd
                ALUOp    = 2'b10; // Indica operacao R
            end
            6'b001000: begin // addi
                RegWrite = 1'b1;
                ALUSrc   = 1'b1; // usa immediate
                RegDst   = 1'b0; // usa rt
                ALUOp    = 2'b00; // ADD
            end
            6'b100011: begin // lw
                RegWrite = 1'b1;
                ALUSrc   = 1'b1; // usa immediate
                MemtoReg = 1'b1; // dados da memoria
                MemRead  = 1'b1;
                ALUOp    = 2'b00; 
            end
            6'b101011: begin // sw
                ALUSrc   = 1'b1; // usa immediate
                MemWrite = 1'b1;
                ALUOp    = 2'b00; 
            end
            6'b000100: begin // beq
                Branch   = 1'b1;
                ALUOp    = 2'b01; // sub - comparacao
            end
            6'b000010: begin // j
                Jump     = 1'b1;
            end
            default: begin // instrucao nnaoo suportada

            end
        endcase
    end
endmodule