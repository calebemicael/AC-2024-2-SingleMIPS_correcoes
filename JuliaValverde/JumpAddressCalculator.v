module JumpAddressCalculator(
    input wire [25:0] instruction,
    input wire [3:0] PCPlus4,
    output wire [31:0] JumpAddress
);

    assign JumpAddress = {PCPlus4, instruction, 2'b00};

endmodule