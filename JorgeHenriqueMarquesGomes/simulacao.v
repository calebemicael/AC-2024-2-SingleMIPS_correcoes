`timescale 1ns/1ns
`include "Add4.v"
`include "FetchUnit.v"
`include "MemoriaDeInstrucoes.v"
`include "Adder32.v"
`include "ALU.v"
`include "ALUcontrol.v"
`include "Control.v"
`include "MUX.v"
`include "MUX5.v"
`include "DataMemory.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"
`include "jumpAddresser.v"

module Simulacao;

    reg clk;
    reg reset;
    wire [31:0] instrucao;

    // Instancia o módulo FetchUnit
    FetchUnit unidade_fetch (
        .clk(clk),
        .reset(reset),
        .instrucao(instrucao)
    );



    // Gera o clock
    always #10 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No comeco, PC desconhecido.
        #10
        reset = 1;  // Reseta o PC
        #20
        reset = 0;  // Volta a Habilitar o PC, e comeca a buscar instrucao
        // Executa alguns ciclos de clock para verificar o fetch
        #400;
        $display("1: o programa definiu $t0 como 3 e $t1 como zero entao soma 1 a $t1 e compara $t1 com $t0 e se os dois forem iguais ele encerra o loop\n2: se nao ele da um jump soma 1 a $t1 e compara de novo para o loop\n3: entao ele torna $t1 em 1 e subtrai $t1 de $t2 e guarda em $t3\n4: entao salva o conteudo de $t3 na memoria em 0($zero) e depois carrega o conteudo de 0($zero) em $t4 e faz a soma de $t3 e $t4 em $t5");
        $finish;
    end

    // Monitora as instruções buscadas
    always @(posedge clk) begin
        $display("PC: %d, Instrução: %b", unidade_fetch.pc[9:2], instrucao);
        
        //$display("->: %d, registrador: %h", unidade_fetch.regfile.registers[8], unidade_fetch.regfile.registers[8]);
    end
    
    // Bloco para inicializar o dump de formas de onda
    // em um VCD para ver no GTK Wave.
    initial begin
        $dumpfile("simulacao.vcd"); // Nome do arquivo de saída
        $dumpvars(0, Simulacao);    // Registrar todas as variáveis deste módulo
    end

endmodule
