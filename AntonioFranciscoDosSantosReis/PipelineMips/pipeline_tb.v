`timescale 1ns/1ns

`include "main.v"

module pipeline_tb;
    reg clk, reset;

    main dut (.clk(clk), .reset(reset));

    always begin
        #5 clk = ~clk;  // Clock com período de 2ns
        //PcSrcE = ~PcSrcE;
    end

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, pipeline_tb); 

        clk = 0;
        PcSrcE = 0;
        reset = 1;
        #5
        reset = 0; 
        #5     
        #400
        $finish;         // Simulação encerra após 80ns
    end

endmodule
