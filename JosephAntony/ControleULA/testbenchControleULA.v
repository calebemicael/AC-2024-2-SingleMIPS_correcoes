`timescale 1ns/1ps

    module testbenchControleULA;
        reg [1:0] opALU;
        reg [5:0] funct;
        wire [3:0] ALUcontrol;

        controleULA uut(
            .opALU(opALU),
            .funct(funct),
            .ALUcontrol(ALUcontrol)
        );

        initial begin
        $dumpfile("testbenchControleULA.vcd");
        $dumpvars(0, testbenchControleULA, opALU, funct, ALUcontrol);

        $monitor("opALU: %b | funct: %b | ALUControl: %b", opALU, funct, ALUcontrol);


        opALU = 2'b00; funct = 6'b000000; #10;  // soma LW ou SW
        opALU = 2'b01; funct = 6'b000000; #10;  // sub  beq
        opALU = 2'b10; funct = 6'b100000; #10;  // soma do tipo R
        opALU = 2'b10; funct = 6'b100010; #10;  // sub do tipo R
        opALU = 2'b10; funct = 6'b100100; #10;  // and do tipo R
        opALU = 2'b10; funct = 6'b100101; #10;  // or do tipo R
        opALU = 2'b10; funct = 6'b101010; #10;  // slt do tipo R
        opALU = 2'b10; funct = 6'b000000; #10;  // instrucao invalida


        #30;
        $finish;
        end
    endmodule
