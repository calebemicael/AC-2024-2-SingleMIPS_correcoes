module control (
    input [5:0] opcode,
    output reg reg_dst,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg [1:0] alu_op,
    output reg jump
);
    always @(*) begin
        case (opcode)
            6'b000000: {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op, jump} = {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10, 1'b0}; // R-type
            6'b100011: {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op, jump} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00, 1'b0}; // lw
            6'b101011: {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op, jump} = {1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00, 1'b0}; // sw
            6'b000100: {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op, jump} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 1'b0}; // beq
            6'b000010: {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op, jump} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b1}; // j
            default:   {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op, jump} = 10'b0;
        endcase
    end
endmodule