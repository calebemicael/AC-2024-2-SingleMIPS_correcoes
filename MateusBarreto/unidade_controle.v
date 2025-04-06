module unidade_controle (
    input [5:0] opcode,    // código de operação (opcode)
    output reg RegDst,     // controle para selecionar o destino do registrador
    output reg ALUSrc,     // controle para escolher entre registrador ou imediato para ALU
    output reg MemtoReg,   // controle para selecionar entre ALU e memória para registrador de destino
    output reg RegWrite,   // habilitação para escrita em registrador
    output reg MemRead,    // controle para ler da memória
    output reg MemWrite,   // controle para escrever na memória
    output reg Branch,     // controle para operações de salto condicional
    output reg Jump,       // controle para operações de salto incondicional
    output reg [1:0] ALUOp // controle para selecionar a operação da ALU
);
    always @(*) begin
        case(opcode) // Dependendo do valor do opcode, define-se os sinais de controle
            6'b000000: begin // R-R
                RegDst   = 1;    
                ALUSrc   = 0;    
                MemtoReg = 0;    
                RegWrite = 1;    // A escrita no registrador é habilitada
                MemRead  = 0;    
                MemWrite = 0;    
                Branch   = 0;    
                Jump     = 0;    
                ALUOp    = 2'b10; // A ALU realiza uma operação aritmética (add, sub, etc.)
            end
            6'b100011: begin // LW (Load Word) 
                RegDst   = 0;    
                ALUSrc   = 1;    // Usa o valor imediato (offset) como segundo operando para a ALU
                MemtoReg = 1;    // O valor de destino do registrador vem da memória
                RegWrite = 1;    // A escrita no registrador é habilitada
                MemRead  = 1;    // Realiza a leitura da memória
                MemWrite = 0;     
                Branch   = 0;    
                Jump     = 0;    
                ALUOp    = 2'b00; // A ALU realiza uma operação de soma para calcular o endereço
            end
            6'b101011: begin // SW (Store Word) 
                RegDst   = 0;    
                ALUSrc   = 1;    // Usa o valor imediato (offset) como segundo operando para a ALU
                MemtoReg = 0;    
                RegWrite = 0;    
                MemRead  = 0;    
                MemWrite = 1;    // Realiza a escrita na memória
                Branch   = 0;    
                Jump     = 0;    
                ALUOp    = 2'b00; // Memsa coisa da de cima
            end
            6'b000100: begin // BEQ (Branch if Equal) 
                RegDst   = 0;    
                ALUSrc   = 0;    
                MemtoReg = 0;    
                RegWrite = 0;    
                MemRead  = 0;    
                MemWrite = 0;    
                Branch   = 1;    // Realiza o salto se for true
                Jump     = 0;    
                ALUOp    = 2'b01; // A ULA realiza uma operação de subtração para verificar igualdade
            end
            6'b000010: begin // JUMP (J) 
                RegDst   = 0;    
                ALUSrc   = 0;    
                MemtoReg = 0;    
                RegWrite = 0;    
                MemRead  = 0;    
                MemWrite = 0;    
                Branch   = 0;    
                Jump     = 1;    // Realiza o JUMP
                ALUOp    = 2'b00; // Nenhuma operação de ALU é realizada
            end
            6'b001000: begin // ADDI (Add Immediate) 
                RegDst   = 0;    
                ALUSrc   = 1;    // Usa o valor imediato  como segundo operando
                MemtoReg = 0;    
                RegWrite = 1;    // A escrita no registrador é habilitadaa
                MemRead  = 0;    
                MemWrite = 0;    
                Branch   = 0;   
                Jump     = 0;    
                ALUOp    = 2'b00; // Mesmo da de cima
            end
            default: begin // Caso default para opcode não reconhecido
                RegDst   = 0;
                ALUSrc   = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 0;
                Jump     = 0;
                ALUOp    = 2'b00; 
            end
        endcase
    end
endmodule
