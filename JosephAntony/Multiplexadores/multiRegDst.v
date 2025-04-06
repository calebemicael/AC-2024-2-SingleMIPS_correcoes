module multiRegDst (rt, rd, RegDst, RegDst_out);
    input [4:0] rt, rd;
    input RegDst;
    output [4:0] RegDst_out;

    assign RegDst_out = RegDst ? rd : rt;

endmodule