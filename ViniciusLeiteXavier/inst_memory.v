module inst_memory (
    input wire [31:0] address, // Endereço da instrução
    output wire [31:0] instruction // Instrução lida
);

    /*
     Unidade de memória responsável por armarzenar as instruções
     de um programa e fornercer instruçoes dado um endereço
    */

    reg [31:0] memory [255:0];

    integer i;
    initial begin

        /*
         a instrução jump para o primeiro endereçamento de
         memória cria um laço infinito
        */

        memory[0] = 32'b10001101010010010000000000000000; // lw $t1, 0($t2)
        memory[1] = 32'b10001101011010100000000000000000; // lw $t2, 0x0($t3)
        memory[2] = 32'b00000001001010100101100000100000; // add $t3 $t1 $t2
        memory[3] = 32'b00000001001010100110000000100101; // or $t4 $t1 $t2
        memory[4] = 32'b00000001011011000110100000100100; // and $t5 $t3 $t4
        memory[5] = 32'b10101101010110000000000000000100; // sw $t8, 0x4($t2)
        memory[6] = 32'b00001000010000000000000000000000; // j 0x00400000

        // Zera o restante da memoria
        for (i = 7; i < 256; i = i + 1) begin
            memory[i] = 32'b0;
        end

    end

    // intervalo de 8 bits, começando do bit 0 até o bit 7. Gerando 256 possibilidades.
    assign instruction = memory[address[9:2]];

endmodule
