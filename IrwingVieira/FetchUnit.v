module FetchUnit(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    input wire branch, zeroALU,     // Opera com o program counter de maneira diferente a do usual.
    input jumpSignal,               // Implementa um pulo na lógica do program counter.
    input [25:0] jumpAddress,       // Endereço do jumpAddress.
    output wire [31:0] instrucao,   // Instrução buscada da memória
    output wire andMuxSignal        // Vai ser o que permitirá a troca do pc count pelo branch. 
);

    // Fios para conexão entre módulos
    wire [31:0] pc_incrementado;
    wire [31:0] enderecoBranch;
    wire [31:0] enderecoJump;
    reg  [31:0] pc;

    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(pc_incrementado)
    );

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    InstructionMemory memoria (
        .addr(pc),
        .instrucao(instrucao)
    );

    //Módulo de operação para o enventual beq:
    BEQInstruction branchEqual(
        .offset(instrucao[15:0]),
        .currentPC(pc),
        .branchSignal(branch),
        .aluZero(zeroALU),
        .saida(enderecoBranch),
        .andMux(andMuxSignal)
    );

    //Modulo de operação para o eventual jump:
    Jump opearacaoJump(
        .actualPC(pc),
        .jumpAddress(jumpAddress),
        .newPC(enderecoJump)
    );   

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            if(jumpSignal) begin
                pc <= enderecoJump;
            end else if (andMuxSignal) begin
                pc <= enderecoBranch;
            end else begin
                pc <= pc_incrementado;
            end
        end
    end

endmodule
