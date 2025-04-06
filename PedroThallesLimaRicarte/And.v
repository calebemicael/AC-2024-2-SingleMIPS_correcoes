module And(
    input wire Branch,
    input wire zzero,
    output wire PCSrc
);

assign PCSrc = Branch & zzero;

endmodule