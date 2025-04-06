module jump_address (
    input [25:0] instr_target, // Campo target da instrução (26 bits)
    input [31:0] pc_atual,     
    output [31:0] jump_addr    // Endereço de destino do Jump
);
    assign jump_addr = {pc_atual[31:28], instr_target, 2'b00}; // Monta o endereço completo
endmodule
