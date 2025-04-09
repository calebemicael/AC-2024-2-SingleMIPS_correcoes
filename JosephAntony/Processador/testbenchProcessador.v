module testbenchProcessador;


    reg clk, reset;
    wire [31:0] instrucao;
    wire [31:0] pc;
    wire [31:0] ALUResult;
    wire Zero;


    processador uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instrucao(instrucao),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );


    always #5 clk = ~clk; 

  
    initial begin
        clk = 0;
        reset = 1;
        #20; 
        reset = 0;  
    end

 
    initial begin
        $dumpfile("out/processador_tb.vcd");
        $dumpvars(0, testbenchProcessador);
    end


    initial begin
        $monitor("Time=%0t | PC=%h | Instrucao=%h | ALU Result=%h | Zero=%b", 
                 $time, pc, instrucao, ALUResult, Zero);
    end


    initial begin
        #200; 
        $finish;
    end

endmodule

