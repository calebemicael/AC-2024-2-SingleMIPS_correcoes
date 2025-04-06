module MUX_32bits_jump(
    input wire[31:0] JumpAdress,
    input wire[31:0] muxAnterior,
    input wire Jump,
    output wire[31:0] out
);

assign out = Jump ? JumpAdress : muxAnterior;

endmodule