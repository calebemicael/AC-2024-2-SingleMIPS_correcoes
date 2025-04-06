module sum4b (
    input wire [31:0] entrada, //entrada atual
     output wire [31:0] saida//resultado com soma
);
    assign saida = entrada + 32'b100;
endmodule
