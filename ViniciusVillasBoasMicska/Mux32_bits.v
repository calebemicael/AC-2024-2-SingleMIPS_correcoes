module Mux32_bits(
    input wire [31:0] false,
    input wire [31:0] true,
    input wire sel,
    output wire [31:0] o_output 
);

  assign o_output = sel ? true : false;

endmodule
