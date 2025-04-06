// Módulo de Memória de Instruções
module InstructionMemory (address, instruction);
    input [31:0] address;
    output [31:0] instruction;

    reg [31:0] memory [0:255];   // Memória de 256 palavras de 32 bits

    assign instruction = memory[address[7:0]];
endmodule
