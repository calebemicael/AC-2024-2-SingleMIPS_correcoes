`timescale 1ns/1ns
`include "MIPS_processor.v"

module Simulation;

    // Entradas e sinais
    reg r_clk;
    reg r_reset;
 

    MIPS_processor processor(
        .i_clk(r_clk),
        .i_reset(r_reset)
    );

    integer i;
    initial begin
        $dumpfile("MIPS_processor.vcd");
        $dumpvars(0, Simulation);

        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, Simulation.processor.fetchUnit.memory.r_memory[i]);  
            $dumpvars(1, Simulation.processor.registers.r_registers[i]);
        end

        r_clk = 0;
        r_reset = 0;

        #5
        r_reset = 1;
        #5
        r_reset = 0;


        
        #1230;
        $finish;
    end

    // Geração de clock
    always #5 r_clk = ~r_clk;

endmodule
