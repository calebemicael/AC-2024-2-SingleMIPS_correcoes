// Módulo ControlUnit
// responsável por gerar os sinais de controle para o processador 
// com base no opcode da instrução.
module controlUnit (
    input wire [5:0] opcode,    // Opcode da instrução
    output reg regDst,          // Define se o destino da escrita no registrador é rd ou rt
    output reg aluSrc,          // Seleciona a fonte do segundo operando da ALU
    output reg memToReg,        // Se ativa, os dados vêm da memória para o registrador
    output reg regWrite,        // Habilita a escrita no banco de registradores
    output reg memRead,         // Habilita a leitura da memória
    output reg memWrite,        // Habilita a escrita na memória
    output reg branch,          // Indica se a instrução é um desvio (beq)
    output reg [1:0] aluOp      // Define a operação a ser executada na ALU
);

    always @(*) begin
        // Sinais padrão (caso não seja uma instrução válida)
        regDst   = 0;
        aluSrc   = 0;
        memToReg = 0;
        regWrite = 0;
        memRead  = 0;
        memWrite = 0;
        branch   = 0;
        aluOp    = 2'b00;

        case (opcode)
            6'b000000: begin // Tipo R (ADD, SUB, AND, OR, SLT)
                regDst   = 1;   // rd recebe o resultado
                aluSrc   = 0;   // Segundo operando vem do registrador
                memToReg = 0;   // Resultado vem da ALU
                regWrite = 1;   // Habilita escrita no registrador
                memRead  = 0;   // Não lê da memória
                memWrite = 0;   // Não escreve na memória
                branch   = 0;   // Não é uma instrução de desvio
                aluOp    = 2'b10; // ALU definida pelo campo funct
            end
            6'b100011: begin // LW (Load Word)
                regDst   = 0;   // rt recebe o resultado
                aluSrc   = 1;   // Segundo operando vem da memória
                memToReg = 1;   // Resultado vem da memória
                regWrite = 1;   // Escreve no registrador
                memRead  = 1;   // Lê da memória
                memWrite = 0;   // Não escreve na memória
                branch   = 0;   // Não é desvio
                aluOp    = 2'b00; // Operação ADD (para calcular endereço)
            end
            6'b101011: begin // SW (Store Word)
                regDst   = 0;   // Não importa (não escreve no registrador)
                aluSrc   = 1;   // Segundo operando vem da memória
                memToReg = 0;   // Não importa
                regWrite = 0;   // Não escreve no registrador
                memRead  = 0;   // Não lê da memória
                memWrite = 1;   // Escreve na memória
                branch   = 0;   // Não é desvio
                aluOp    = 2'b00; // Operação ADD (para calcular endereço)
            end
            6'b000100: begin // BEQ (Branch if Equal)
                regDst   = 0;   // Não importa (não escreve no registrador)
                aluSrc   = 0;   // Segundo operando vem do registrador
                memToReg = 0;   // Não importa
                regWrite = 0;   // Não escreve no registrador
                memRead  = 0;   // Não lê da memória
                memWrite = 0;   // Não escreve na memória
                branch   = 1;   // Instrução de desvio
                aluOp    = 2'b01; // Operação SUB (para comparar igualdade)
            end
            default: begin // Instrução inválida (mantém sinais padrão)
                regDst   = 0;
                aluSrc   = 0;
                memToReg = 0;
                regWrite = 0;
                memRead  = 0;
                memWrite = 0;
                branch   = 0;
                aluOp    = 2'b00;
            end
        endcase
    end

endmodule
