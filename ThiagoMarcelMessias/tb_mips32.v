`include "mips_32.v"
`timescale 1ns / 1ps

module tb_mips_32();

    // Declaração de sinais de controle do processador
    reg clk, reset;
    wire [31:0] pc_out, alu_result;
    wire [31:0] instrucao;  // Nova variável para capturar a instrução lida

    // Instanciando o processador MIPS
    mips_32 mips_instance (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

    // Instância da memória de instruções
    MemoriaDeInstrucoes instrucion_memory (
        .addr(pc_out), // Endereço do PC (conectado ao pc_out)
        .instrucao(instrucao) // Passa a instrução para o processador
    );

    // Conectando a instrução lida ao sinal interno do processador
    assign mips_instance.instr = instrucao;

    // Gerando o clock e o reset
    initial begin
        clk = 0;
        reset = 1;
        
        // Aplicando o reset no início
        #10 reset = 0;  // Libera o reset após 10 unidades de tempo
    end

    // Gerando o sinal de clock
    always begin
        #5 clk = ~clk;  // Clock com período de 10 unidades de tempo
    end

    // Monitorando a execução da simulação
    initial begin
        // Monitorando o PC, ALU e a instrução lida
        $monitor("PC = %h, ALU Result = %h, Instruction = %h", pc_out, alu_result, instrucao);
            $dumpfile("mips_32_tb.vcd");  
        $dumpvars(0, tb_mips_32);
    end

    // Inicializando a simulação e passando o arquivo hex para a memória
    initial begin
        $readmemh("codigo.mem", instrucion_memory.memoria); // Carrega o arquivo "soma.hex" na memória de instruções
        
        // Rodando a simulação por um número de ciclos
        #100 $finish;  // Finaliza após 100 unidades de tempo (ajuste conforme necessário)
    end

endmodule