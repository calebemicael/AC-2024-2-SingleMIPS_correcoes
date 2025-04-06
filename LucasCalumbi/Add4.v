
module Add4(
    input wire [31:0] i_in,        // Endereço atual do PC
    output wire [31:0] o_out       // Endereço incrementado
);
    assign o_out = i_in + 32'd4;     // Soma 4 ao valor de entrada
endmodule
