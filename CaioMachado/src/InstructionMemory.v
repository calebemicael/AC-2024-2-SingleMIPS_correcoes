module InstructionMemory (
    input [31:0] address,
    output [31:0] instruction
);
    reg [31:0] memory[0:255];

    initial begin
        // Exemplo de código assembly: add $t0, $t1, $t2
        memory[0] = 32'b00000001001010100100000000100000; // add $t0, $t1, $t2
    end

    assign instruction = memory[address[7:2]]; // Divide por 4 para endereçamento de palavras
endmodule