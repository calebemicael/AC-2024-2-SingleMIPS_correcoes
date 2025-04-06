module dMem (
    input clk,
    input [31:0] addr,
    input [31:0] write_data,
    input mem_write,
    output [31:0] read_data
);
reg [31:0] mem[0:255];
always @(posedge clk) begin
    if (mem_write) mem[addr[31:2]] <= write_data;
end
assign read_data = mem[addr[31:2]];
endmodule