module MUX_PCSrc(
    input wire [31:0] pc_4,
    input wire [31:0] sum,
    input wire PCSrc,
    output wire [31:0] programAddr
);

    assign programAddr = PCSrc ? sum : pc_4;

endmodule