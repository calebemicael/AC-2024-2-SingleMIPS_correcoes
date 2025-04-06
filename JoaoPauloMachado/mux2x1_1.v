module mux2x1_1 (
    input wire [4:0] rdField,
    input wire [4:0] rtField,
    input wire RegDst,
    output wire [4:0] out
);

    assign out = (RegDst) ? rdField : rtField;

endmodule


