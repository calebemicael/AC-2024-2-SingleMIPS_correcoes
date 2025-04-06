`timescale 1ns/1ns
`include "MIPS.v"

module Simulation;

    // Entradas e sinais
    reg clk;
    reg reset;
 

    MIPS processor(
        .clk(clk),
        .reset(reset)
    );

    integer i;
    initial begin
        $dumpfile("MIPS.vcd");
        $dumpvars(0, Simulation);

        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, Simulation.processor.fetchUnit.memory.memory[i]);  
            $dumpvars(1, Simulation.processor.registers.registers[i]);
        end

        clk = 0;
        reset = 0;

        #5
        reset = 1;
        #5
        reset = 0;


        
        #1000;
        $finish;
    end

    // Geração de clock
    always #5 clk = ~clk;

endmodule