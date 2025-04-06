module DataMemory (
    input clk,
    input mem_write,
    input mem_read,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory[0:255];

    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[7:2]] <= write_data;
        end
    end

    assign read_data = mem_read ? memory[address[7:2]] : 0;
endmodule