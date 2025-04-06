module controlUnit(
    input [5:0] opcode,          // Campo opcode da instrução
    output reg RegDst,           // Sinal do reg destino
    output reg ALUSource,           // Sinal pro segundo operando da ALU
    output reg MemtoReg,         // Sinal para fonte do dado a ser escrito no reg
    output reg RegWrite,         // Sinal para escrever no banco de registradores
    output reg MemRead,          // Sinal para ler da memória de dados
    output reg MemWrite,         // Sinal para escrever na memória de dados
    output reg Branch,           // Sinal para desvio condicional (BEQ)
    output reg Jump,             // Sinal para salto (JUMP)
    output reg [1:0] ALUOp       // Sinal de controle para a ALU
);
    always @(opcode) begin
        case (opcode)
            6'b000000: begin // Instrução R
                
                ALUOp = 2'b10;
                ALUSource = 0;
                RegDst = 1;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                
            end
            6'b100011: begin // LW
                
                ALUOp = 2'b00;
                ALUSource = 1;
                RegDst = 0;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                
            end
            6'b101011: begin // SW 
                
                ALUOp = 2'b00;
                ALUSource = 1;
                RegDst = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                Jump = 0;
                
            end
            6'b000100: begin // BEQ 
                
                ALUOp = 2'b01;
                ALUSource = 0;
                RegDst = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                Jump = 0;
                
            end
            6'b000010: begin // JUMP
                
                ALUOp = 2'b00;
                ALUSource = 0;
                RegDst = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                Jump = 1;
                
            end
            6'b001000: begin // ADDI
                
                ALUOp = 2'b00;
                ALUSource = 1;
                RegDst = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                
            end
            default: begin // Caso padrão
                
                ALUOp = 2'b00;
                ALUSource = 0;
                RegDst = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                Jump = 0;
                
            end
        endcase
    end
endmodule