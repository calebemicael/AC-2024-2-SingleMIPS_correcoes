// Módulo multiplexador 32 bits
module MUX2to1(in0, in1, sel, out);
    input [31:0] in0, in1;
    input sel;
    output [31:0] out;

    assign out = (sel) ? in1 : in0; // Seleciona in1 se sel for 1, caso contrário in0
endmodule
