module MUX2to1_PC(
    input  wire [31:0] pc_plus_4,    // Valor de PC + 4 (execução normal)
    input  wire [31:0] branch_target, // Valor do branch target
    input  wire        branch_taken,  // Sinal de seleção (branch && Zero)
    output wire [31:0] next_pc       // Próximo valor do PC
);
    assign next_pc = branch_taken ? branch_target : pc_plus_4;
endmodule