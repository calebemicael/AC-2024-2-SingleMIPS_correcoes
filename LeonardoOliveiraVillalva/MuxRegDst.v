module MuxRegDst (
    input wire [4:0] rt,
    input wire [4:0] rd,
    input wire RegDst,
    output wire [4:0] WriteRegister
);

    assign WriteRegister = (RegDst) ? rd : rt;

endmodule