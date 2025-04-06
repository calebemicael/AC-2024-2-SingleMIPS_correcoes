module unidadeControle (
    input wire [5:0] opcode,      // Campo opcode da instrução
    output reg RegDst,            // Seleção do destino do registrador
    output reg ALUSrc,            // Seleção da fonte da ALU
    output reg MemtoReg,          // Controle do MUX da memória
    output reg RegWrite,          // Sinal de escrita no registrador
    output reg MemRead,           // Sinal de leitura da memória
    output reg MemWrite,          // Sinal de escrita na memória
    output reg Branch,            // Sinal de desvio condicional
    output reg [1:0] ALUOp        // Controle da ALU
);

    always @(*) begin
        case (opcode)
            6'b000000: begin // Tipo R
                RegDst   = 1;
                ALUSrc   = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 0;
                ALUOp    = 2'b10;
            end
            6'b100011: begin // LW (Load Word)
                RegDst   = 0;
                ALUSrc   = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead  = 1;
                MemWrite = 0;
                Branch   = 0;
                ALUOp    = 2'b00;
            end
            6'b101011: begin // SW (Store Word)
                RegDst   = 0;
                ALUSrc   = 1;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 1;
                Branch   = 0;
                ALUOp    = 2'b00;
            end
            6'b000100: begin // BEQ (Branch if Equal)
                RegDst   = 0;
                ALUSrc   = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 1;
                ALUOp    = 2'b01;
            end
            6'b001000: begin // ADDI
                RegDst = 0;
                ALUSrc = 1;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
            end
            default: begin // Instrução não reconhecida
                RegDst   = 0;
                ALUSrc   = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 0;
                ALUOp    = 2'b00;
            end
        endcase
    end

endmodule
