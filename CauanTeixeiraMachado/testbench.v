`include "mips.v"
`include "Add4.v"
`include "Adder32.v"
`include "ALU.v"
`include "ALUControl.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "MemoriaDeInstrucoes.v"
`include "Mux2_5bit.v"
`include "Mux2.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"

module TesteMIPS();
    reg clock;
    reg reset;

    mips processador(
        .clock(clock),
        .reset(reset)
    );


    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end


    initial begin

        reset = 1;
        #10;
        reset = 0;


        #200;


        $display("Iniciando simulação...");


        $monitor("Time=%0d pc=%0h instrucao=%0h",
                 $time,
                 processador.pc,
                 processador.instrucao);


        $finish;
    end


    initial begin
        $dumpfile("mips.vcd");
        $dumpvars(0, TesteMIPS);
    end
endmodule