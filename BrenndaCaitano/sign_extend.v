module sign_extend (
    input [15:0] imm,
    output [31:0] ext_imm
);
assign ext_imm = {{16{imm[15]}}, imm};
endmodule