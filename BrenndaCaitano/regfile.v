module regfile (
    input clk,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input reg_write,
    output [31:0] read_data1,
    output [31:0] read_data2
);
reg [31:0] regs[0:31];
initial regs[0] = 0;
always @(posedge clk) begin
    if (reg_write && write_reg != 0) regs[write_reg] <= write_data;
end
assign read_data1 = regs[read_reg1];
assign read_data2 = regs[read_reg2];
endmodule