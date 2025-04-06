module Mux_5bits(
    input wire [4:0] i_false,
    input wire[4:0] i_true,
    input wire i_sel,
    output wire [4:0] o_output
);

    genvar i; 
    generate
        for (i = 0; i < 5; i = i + 1) begin : mux_loop
            assign o_output[i] = (i_false[i] & ~i_sel) | (i_true[i] & i_sel); 
        end
    endgenerate

endmodule