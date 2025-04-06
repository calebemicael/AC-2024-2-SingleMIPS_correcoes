`include "Add4.v"
`include "InstructionMemory.v"

module FetchUnit(
    input wire i_clk,                
    input wire i_reset,               
    input wire [31:0] i_pc_address,
    output wire [31:0] o_instruction,  
    output wire [31:0] o_incremented_pc
);

    reg [31:0] r_pc;

    
    Add4 add4 (
        .i_in(r_pc),
        .o_out(o_incremented_pc)
    );

    InstructionMemory memory (
        .i_address(r_pc),
        .o_instruction(o_instruction)
    );

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            r_pc <= 32'b0;            
        end else begin
            r_pc <= i_pc_address;  
        end
    end

endmodule
