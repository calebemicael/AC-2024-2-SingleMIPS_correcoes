module Mux_32bits(
    input wire [31:0] i_false,
    input wire [31:0] i_true,
    input wire i_sel,
    output wire [31:0] o_output 
);

    genvar i; 
    generate
        for (i = 0; i < 32; i = i + 1) begin : mux_loop
            assign o_output[i] = (i_false[i] & ~i_sel) | (i_true[i] & i_sel); 
        end
    endgenerate

endmodule