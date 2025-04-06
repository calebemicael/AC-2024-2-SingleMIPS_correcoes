module ConcatJump (
    input wire [27:0] instruShift, 
    input wire [3:0] pcPlus4,
    output wire [31:0] JumpAddress
);

    assign JumpAddress = {pcPlus4, instruShift};

endmodule
