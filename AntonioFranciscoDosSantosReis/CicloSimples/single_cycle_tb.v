`timescale 1ns/1ns

`include "main.v"


module single_cycle_tb;
    reg clk, reset;

    top uut(.clk(clk), .reset(reset));

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("single_cycle_tb.vcd");
        $dumpvars(0, single_cycle_tb); 

        clk = 0;
        reset = 1;
        #5
        reset = 0;
        #400
        $finish; 
    end

endmodule