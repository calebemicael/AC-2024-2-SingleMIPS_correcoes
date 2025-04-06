`timescale 1ns / 1ps

module tb_mips16;
    
    reg clk;
    reg reset;
   
    wire [15:0] pc_out;
    wire [15:0] alu_result;
    
    
    mips_16 uut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

   
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    
    initial begin
        $dumpfile("mips16_tb.vcd");  
        $dumpvars(0, tb_mips16);     
        
        reset = 1;
        #100;  
        reset = 0;

        #1000;
        $finish;
    end
endmodule
