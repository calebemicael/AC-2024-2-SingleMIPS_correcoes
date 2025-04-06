module MuxPCSrc(
    input wire [31:0] PCPlus4,     // Próximo endereço sequencial
    input wire [31:0] BranchAddress, // Endereço de branch
    input wire Branch,             // Sinal de controle
    input wire Zero,               // Sinal Zero da ALU
    output wire [31:0] NextPC      // Próximo endereço do PC
);

    assign NextPC = (Branch & Zero) ? BranchAddress : PCPlus4;

endmodule