module somador_pc (
    input [31:0] pc_atual,
    output [31:0] pc_proximo
);
    assign pc_proximo = pc_atual + 32'h00000004;
// é um somador, meio que não precisa de explicação
endmodule
