module Mux5( 
    input [4:0] A,
    input [4:0] B, 
    input S, 
    output wire [4:0] X
);
    assign X = (S) ? B : A;
endmodule