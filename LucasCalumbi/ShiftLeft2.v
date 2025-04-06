
module ShiftLeft2(
    input wire [31:0] i_in,         
    output wire [31:0] o_out        
);

    assign o_out = i_in << 2;          

endmodule
