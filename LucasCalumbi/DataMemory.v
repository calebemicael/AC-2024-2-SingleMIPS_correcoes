
module DataMemory(
    input wire i_clk,               
    input wire i_mem_read_sig,           
    input wire i_mem_write_sig,           
    input wire [31:0] i_address,    
    input wire [31:0] i_write_data,   
    output wire [31:0] o_read_data    
);

    reg [31:0] r_memory [255:0];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            r_memory[i] = 32'b0;
        end
    end

    assign o_read_data = (i_mem_read_sig) ? r_memory[i_address[9:2]] : 32'b0;

    always @(*) begin
        if (i_mem_write_sig) begin
            r_memory[i_address[9:2]] = i_write_data; 
        end
    end

endmodule
