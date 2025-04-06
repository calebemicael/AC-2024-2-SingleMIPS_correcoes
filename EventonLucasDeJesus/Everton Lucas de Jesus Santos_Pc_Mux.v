// MUX para Seleção do Próximo Endereço do PC
module PC_MUX(pc_plus_4, branch_address, branch, zero, next_pc);
    input [31:0] pc_plus_4;
    input [31:0] branch_address;
    input branch;
    input zero;
    output [31:0] next_pc;

    assign next_pc = (branch & zero) ? branch_address : pc_plus_4;
endmodule
