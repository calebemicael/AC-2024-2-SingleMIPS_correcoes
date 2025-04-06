module mux2x1_2(
    input wire [31:0] signExtended,
    input wire [31:0] dataRegister2,
    input wire ALUSrc,
    output wire [31:0] out
);
    
    assign out = (ALUSrc) ? signExtended : dataRegister2;

endmodule