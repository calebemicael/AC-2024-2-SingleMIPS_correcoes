module Mux32( 
    input [31:0] A,
    input [31:0] B, 
    input S, 
    output wire [31:0] X
);
    assign X = (S) ? B : A;
endmodule