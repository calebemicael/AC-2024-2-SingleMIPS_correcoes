// Módulo multiplexador 5 bits
module MUX2to1_5bit(in0, in1, sel, out);
    input [4:0] in0, in1;
    input sel;
    output [4:0] out;

    assign out = (sel) ? in1 : in0; // Seleciona in1 se sel for 1, caso contrário in0
endmodule
