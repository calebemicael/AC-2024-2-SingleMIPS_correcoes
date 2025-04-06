`timescale 1ns / 1ps

module mips_tb;

    // Entradas da simulação
    reg clk;
    reg reset;

    wire [31:0] pc;          // Program Counter (contador de programa) - Variável que armazena o endereço da próxima instrução a ser executada. Tem 32 bits, o que permite endereçar até 4 GB de memória.
    wire [31:0] instruction; // Instrução atual - Variável que armazena a instrução que está sendo processada no momento. Também com 32 bits, para armazenar uma instrução de 32 bits.
    wire RegWrite;           // RegWrite - Sinal de controle que indica se a escrita no banco de registradores está habilitada. Se for 1, os dados serão escritos no registrador destino.
    wire ALUSrc;             // ALUSrc - Sinal de controle que determina a fonte do segundo operando para a ALU. Se for 1, o segundo operando vem de um valor imediato; se for 0, o segundo operando vem de um registrador.
    wire Branch;             // Branch - Sinal de controle que indica se a instrução é um desvio (branch). Se for 1, a execução do programa saltará para um novo endereço baseado em uma condição.


    // Array para armazenar o estado dos 32 registradores do banco
    reg [31:0] regBankState [31:0];

    // Instância do processador MIPS
    mips_processor uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .Branch(Branch)
    );

    genvar i, j, k;
    integer idx;

    // Gerando os 32 registradores para o banco de registradores
    generate
    for (i = 0; i < 32; i = i + 1) begin : Banco_de_Registradores
        wire [31:0] registrador;
        assign registrador = uut.reg_file.registers[i];
    end
    endgenerate

    generate
    for (k = 0; k < 256; k = k + 1) begin : Memoria_de_Dados
        wire [31:0] data;
        assign data = uut.data_mem.memory[k];
    end
    endgenerate

    generate
    for (j = 0; j < 256; j = j + 1) begin : Memoria_de_Instrucoes
        wire [31:0] instr_mem;
        assign instr_mem = uut.imem.memory[j];
    end
    endgenerate

    initial begin
        
        $dumpfile("mips_tb.vcd"); // Arquivo para GTKWave
        $dumpvars(0, mips_tb);

        // Inicializa sinais
        clk = 0;
        reset = 1;

        #10 reset = 0; // Desativa o reset após um tempo

        // Carrega o arquivo de memória de instruções
        $readmemb("teste.mem", uut.imem.memory);
        
        // Gera 40 ciclos de clock (período total de 20 ns por ciclo)
        repeat (40) begin
            #5 clk = ~clk;
        end

    end

    always @(posedge clk) begin
        for (idx = 0; idx < 32; idx = idx + 1) begin
            regBankState[idx] = uut.reg_file.registers[idx];
        end
    end
endmodule
