module sum32b (
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] res //resultado da soma
);

    assign res = a + b; //soma 
endmodule