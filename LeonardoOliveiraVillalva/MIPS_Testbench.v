module MIPS_Testbench;
    reg clk;
    reg reset;

    MIPS mips (.clk(clk), .reset(reset));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1; 
        #10;
        reset = 0; 

        #100;

        $finish;
    end

    initial begin
        $monitor("Time: %0d, PC: %h, Instruction: %h, ALUResult: %h, Zero: %b",
                 $time, mips.PCValue, mips.Instruction, mips.ALUResult, mips.Zero);
    end

endmodule