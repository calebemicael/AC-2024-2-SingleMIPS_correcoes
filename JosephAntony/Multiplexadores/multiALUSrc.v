module multiALUSrc (rt, sinalImediato, ALUSrc, entrada2ALU);
    input [31:0] rt, sinalImediato;
    input ALUSrc;
    output [31:0] entrada2ALU;

    assign entrada2ALU = ALUSrc ? sinalImediato : rt;
endmodule