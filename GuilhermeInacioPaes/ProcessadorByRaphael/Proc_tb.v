`timescale 1ns/1ns
`include "UnidadeDeControle.v"
`include "Adder32.v"
`include "FetchUnit.v"
`include "ulaControle.v"
`include "ALU.v"
`include "DataMemory.v"
`include "Proc.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"
`include "Add4.v"
`include "MemoriaDeInstrucoes.v"
`include "concatenarEndJump.v"

`include "ShiftLeft2J.v"

module Proc_tb;
    reg clk;
    reg reset;

    Proc proc(
        .clk(clk),
        .reset(reset)
    );

    // Gera o clock
    always #5 clk = ~clk;

    integer i;
    integer j;
    initial begin
        $dumpfile("Proc.vcd"); //nome do arquivo de saída
        $dumpvars(0, Proc_tb);    

        // monitorar os registradores internos   
        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, Proc_tb.proc.registradores.registers[i]); //monitora registradores
        end

        for (j = 0; j < 256; j = j + 1) begin
             $dumpvars(2, Proc_tb.proc.dMemory.memory[j]); //monitora a memoria
        end

        // Inicializa sinais
        clk = 0;
        reset = 0;  
        #10
        reset = 1;  
        #10
        reset = 0;  
        #10
    
        
        
    
        #100;
        $finish;
    end


endmodule