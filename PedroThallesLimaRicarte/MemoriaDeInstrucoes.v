module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];

    // Inicialização da memória com algumas instruções
    integer i;
    initial begin
        
        memoria[0] = 32'b10001101001010000000000000000000;  // lw $8, 0($t9)                        
        memoria[1] = 32'b00000001000100000101000000100000;  // add $t10, $8, $16           
        memoria[2] = 32'b10101101001100000000000000000100;  // sw $16, 4($9)               
        memoria[3] = 32'b10001101001100010000000000000100;  // lw $17, 4($9)               
        memoria[4] = 32'b00010010000100010000000000000010;  // beq $16, $17, label
        memoria[5] = 32'b00000000000000000101000000100000;  // add $10, $zero, $zero    # Última linha não pemite que o reg 10 seja zerado
        memoria[6] = 32'b00000000000000001000000000100000;  // add $16, $zero $zero     # penúltima linha não permite que o reg 16 seja zerado    
        memoria[7] = 32'b10001101001100100000000000000100;  // label: lw $18, 4($9)              
        memoria[8] = 32'b00000001010100001001000000100010;  // sub $18, $10, $16     
        memoria[9] = 32'b00000000000000000100000000100000;  // add $8, $zero, $zero
        memoria[10] = 32'b00000000000000000101000000100000;  // add $10, $zero, $zero
        memoria[11] = 32'b00000000000000001000100000100000; // add $17, $zero, $zero
       memoria[12] = 32'b00000000000000001001000000100000;  // add $18, $zero, $zero
       memoria[13] = 32'b10101101001101000000000000000100;  // sw $20, 4($9)
       memoria[14] = 32'b00001000000000000000000000000000;  // j inicio
        
        for (i = 15; i < 256; i = i + 1) begin
            memoria[i] = 32'b0;      // Zera o restante da memór    ia
        end
    end

    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule
