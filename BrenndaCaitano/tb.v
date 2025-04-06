module tb;
reg clk, reset;
mips uut (.clk(clk), .reset(reset));

initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
    #200 $finish;
end
always #5 clk = ~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
end
endmodule