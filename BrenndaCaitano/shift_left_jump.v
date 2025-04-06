module shift_left_jump (
    input [25:0] address,
    input [31:0] pc_plus_4,
    output [31:0] jump_address
);
assign jump_address = {pc_plus_4[31:28], address, 2'b00};
endmodule