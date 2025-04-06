module MuxJump(
    input wire [31:0] NextPC,      // Próximo endereço do PC
    input wire [31:0] JumpAddress, // Endereço de jump
    input wire Jump,               // Sinal de controle
    output wire [31:0] FinalPC     // Endereço final do PC
);

    assign FinalPC = (Jump) ? JumpAddress : NextPC;

endmodule