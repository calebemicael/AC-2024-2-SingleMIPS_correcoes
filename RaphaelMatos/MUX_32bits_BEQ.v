module MUX_32bits_BEQ(
    input wire[31:0] AddResult,
    input wire[31:0] AluResult,
    input wire seletor,
    output wire[31:0] out
);

assign out = seletor ? AluResult : AddResult;

endmodule