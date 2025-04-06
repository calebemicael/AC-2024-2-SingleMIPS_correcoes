
module ShiftLeft2_26to28bits(
    input wire [25:0] i_in,      
    output wire [27:0] o_out    
);

    assign o_out = i_in << 2;     

endmodule