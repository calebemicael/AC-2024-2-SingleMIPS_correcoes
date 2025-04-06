module muxJump(
    input wire [31:0] JumpAddress,
    input wire [31:0] NoJump,
    input wire Jump,
    output wire [31:0] attPC
);

    assign attPC = Jump ? JumpAddress : NoJump;

endmodule