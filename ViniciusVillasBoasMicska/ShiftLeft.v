module ShiftLeft #(
    parameter DATA_IN = 32,
    parameter DATA_SHIFT = 32,
    parameter SHIFT_AMOUNT = 2
)(
    input wire [DATA_IN-1:0] in,
    output wire [DATA_SHIFT-1:0] out
);

assign out = in << SHIFT_AMOUNT; 

endmodule
