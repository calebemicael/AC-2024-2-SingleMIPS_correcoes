`timescale 1ns/1ns
`include "DataPath.v"

module Simulacao;

    reg clk;
    reg reset;
    wire [31:0] writeData;

    DataPath datapath (
        .clock(clk),
        .reset(reset)
    );

   /*Registradores regs (
        .clock(clk),
        .reset(reset),
        .ReadRegister1(datap.inst[25:21]),
        .ReadRegister2(datap.inst[20:16]),
        .WriteRegister(datap.WRegister),
        .WriteData(datap.saidaMux3),
        .RegWrite(datap.rw),
        .ReadData1(datap.RData1),
        .ReadData2(datap.RData2)
    );*/

    // Geração do clock
    always #10 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No começo, o PC é desconhecido.

        #10 reset = 1;  // Reseta o PC e outros componentes do datapath
        #20 reset = 0;  // Desabilita o reset, permitindo que o PC comece a buscar instruções

        // Executa alguns ciclos de clock para verificar o fetch das instruções
        #100;  // Tempo para observar o funcionamento

        // Encerra a simulação
        $finish;
    end

    // Monitoramento das instruções e dados
    always @(posedge clk) begin
        $display("PC: %h, Instrução: %h", datapath.pc, datapath.inst);  // Exibe o PC e a instrução atual
        //$display("Clock: %d | WriteData: %h", clk, datap.saidaMux3);  // Exibe o dado a ser escrito
    end

    // Bloco para inicializar o dump de formas de onda
    initial begin
        $dumpfile("datapath.vcd"); // Nome do arquivo de saída
        $dumpvars(0, Simulacao);    // Registra todas as variáveis deste módulo para visualização no GTK Wave
    end

endmodule
