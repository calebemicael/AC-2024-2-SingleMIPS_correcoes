module ControlUnit(
    input wire [5:0] Op,        // Opcode
    output reg RegDst,         // Seleciona o registrador de destino
    output reg Branch,         // Branch
    output reg MemRead,        // Leitura de memória
    output reg MemtoReg,       // Seleciona dados da memória para o registrador
    output reg [1:0] ALUOp,    // Opcode da ALU (4 BITS?)
    output reg MemWrite,       // Escrever memória
    output reg ALUSrc,         // Fonte da ALU
    output reg RegWrite        // Escrever nos registradores
);

    // leitura do Opcode
    always @(*) begin
        case (Op)
            6'b000000: begin // Type R
                RegDst = 1'b1;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b10;
            end
            6'b100011: begin // lw
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            6'b101011: begin // sw
                RegDst = 1'bx;
                ALUSrc = 1'b1;
                MemtoReg = 1'bx;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            6'b000100: begin // beq
                RegDst = 1'bx;
                ALUSrc = 1'b0;
                MemtoReg = 1'bx;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b1;
                ALUOp = 2'b01;
            end
            default: begin // default
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