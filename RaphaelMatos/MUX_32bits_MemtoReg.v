module MUX_32bits_MemtoReg(
    input wire[31:0] ReadData,
    input wire[31:0] AluResult,
    input wire MemtoReg,
    output wire[31:0] out
);

assign out = MemtoReg ? ReadData : AluResult;

endmodule