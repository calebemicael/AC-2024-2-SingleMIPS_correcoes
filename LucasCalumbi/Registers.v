
module Registers(
    input wire i_clk,
    input wire [4:0] i_read_register1,  
    input wire [4:0] i_read_register2,  
    input wire [4:0] i_write_register,  
    input wire [31:0] i_write_data,     
    input wire i_reg_write_sig,     
    output wire [31:0] o_read_data1,   
    output wire [31:0] o_read_data2     
);

    reg [31:0] r_registers [31:0];

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            r_registers[i] = 32'b0; 
        end
    end

    assign o_read_data1 = r_registers[i_read_register1];
    assign o_read_data2 = r_registers[i_read_register2];

    always @(posedge i_clk) begin
        if (i_reg_write_sig && i_write_register != 5'b0) begin
            r_registers[i_write_register] <= i_write_data;  
        end
    end

endmodule
