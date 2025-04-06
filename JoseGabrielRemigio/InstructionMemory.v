module InstructionMemory(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instruction // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memory [255:0];

    initial begin
        $readmemb("mips1.bin",memory);
    end

    assign instruction = memory[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
