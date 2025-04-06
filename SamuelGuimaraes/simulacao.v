`timescale 1ns/1ns
`include "CicloUnico.v"
`include "Fetch.v"

module Simulacao;

    reg clk;
    reg reset;
    wire [31:0] instrucao;

    Fetch fetch(
        .clk(clk),
        .reset(reset),
        .jump(_jump),
        .branch(_branch),
        .ALUZero(_ALUZero),
        .fetchInstrucao(_fetchInstrucao),
        .instrucao(instrucao)
    ); 

    wire _jump;
    wire _branch;
    wire _ALUZero;
    wire [31:0] _fetchInstrucao;
    CicloUnico ciclo_unico (
        .instrucao(instrucao),
        .clk(clk),
        .jump(_jump),
        .branch(_branch),
        .ALUZero(_ALUZero),
        .fetchInstrucao(_fetchInstrucao)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset. No comeco, PC desconhecido.
        #10
        reset = 1;  // Reseta o PC
        #20
        reset = 0;  // Volta a Habilitar o PC, e comeca a buscar instrucao

        // Executa alguns ciclos de clock para verificar o fetch
        #200;
        $finish;
    end


    // Monitora as instruções buscadas
    always @(posedge clk) begin
        $display("PC: %d, Instrucao: %h", fetch.pc, instrucao);
    end

    // Monitora o resultado
    initial begin
        $monitor("Time: %0d, ReadData1: %d, ReadData2: %d, ALUResult: %d, Zero: %b",
            $time, ciclo_unico._readData1, ciclo_unico._readData2, ciclo_unico._ALUResult, ciclo_unico._ALUZero);
    end
    
    // Bloco para inicializar o dump de formas de onda
    // em um VCD para ver no GTK Wave.
    initial begin
        $dumpfile("simulacao.vcd"); // Nome do arquivo de saída
        $dumpvars(0, Simulacao);    // Registrar todas as variáveis deste módulo
    end

endmodule
