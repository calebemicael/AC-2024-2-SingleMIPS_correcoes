module SignalExtend(
    input wire [15:0] i_in,         
    output wire [31:0] o_out        
);

    assign o_out = {{16{i_in[15]}}, i_in}; 

endmodule
