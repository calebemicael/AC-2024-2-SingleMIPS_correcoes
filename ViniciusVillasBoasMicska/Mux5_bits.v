module Mux5_bits(
    input wire [4:0] false,
    input wire [4:0] true,
    input wire sel,
    output wire [4:0] o_output 
);

  assign o_output = sel ? true : false;

endmodule
