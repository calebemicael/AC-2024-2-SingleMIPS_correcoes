module instruction_memory(clk, reset, read_address, instruction_out);
    input clk, reset;
    input [31:0] read_address;
    integer i;
    integer k;
    output [31:0] instruction_out;

    reg [31:0] I_MEM [63:0];

    assign instruction_out = I_MEM[read_address];

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            begin
                for(k = 0; k < 64; k=k+1)begin
                    I_MEM[k] <= 32'b00;
                end
            end
        end

       else begin
        /*
           I_MEM[4]  = 32'b000000_10011_10011_01001_00000_100000; //add $t1, $s3, $s3
           I_MEM[8]  = 32'b000000_01001_01001_01001_00000_100000; //add $t1, $t1, $t1
           I_MEM[12] = 32'b000000_01001_10110_01001_00000_100000; //add $t1, $t1, $s6 
           I_MEM[16] = 32'b100011_01001_01000_0000000000000000; // lw $t0, 0($t1)
           I_MEM[20] = 32'b000101_01000_10101_0000000000000100; //bne $t0, $s5, Exit
           I_MEM[24] = 32'b001000_10011_10011_0000000000000001; //addi $s3, $s3, 1
           I_MEM[28] = 32'b000010_00000000000000000000000001; //j 4
        */

           I_MEM[4] = 32'b000000_10000_10011_01000_00000_101010; //# Se $s0 < $s3, então $t0 = 1, senão $t0 = 0
           I_MEM[8] = 32'b000100_01000_00000_0000000000100000;   //# Se $t0 == 0 (ou seja, $s0 >= $s3), salta para EXIT
           I_MEM[12] = 32'b000000_01100_01100_01000_00000_100000; //$t0 = $t4 + $t4 (multiplicação por 2)
           I_MEM[16] = 32'b000000_01000_01000_01000_00000_100000; //$t0 = $t0 + $t0 (multiplicação por 2, agora $t4 * 4)
           I_MEM[20] = 32'b000000_01000_10110_01001_00000_100000; //$t1 = $t0 + $s6 (calcula um endereço base)
           I_MEM[24] = 32'b100011_01001_10001_0000000000000000; //lw $s1, 0($t1) Carrega em $s1 o valor armazenado no endereço $t1
           I_MEM[28] = 32'b001000_10001_10001_0000000000001010; //addi $s1, $s1, 10 # Incrementa $s1 em 10
           I_MEM[32] = 32'b101011_01001_10001_0000000000000000; //sw $s1, 0($t1)  # Armazena $s1 de volta no endereço $t1
           I_MEM[36] = 32'b001000_10000_10000_0000000000000001; //addi $s0, $s0, 1 # Incrementa $s0 em 1
           I_MEM[40] = 32'b000010_00000000000000000000000001; //j 4 # Salta para o endereço 4, Voltando para a primeira posição em I_MEM[4]

           /* 
            $s0 = 2
            $s3 = 5
            $t4 = 2
            $s6 = 0

            Endereço   Valor
            8           59

            1 - iteração:
            slt $t0, $s0, $s3 → Como 2 < 5, $t0 = 1
            beq $t0, $zero, EXIT → Como $t0 != 0, continua execução    
            add $t0, $t4, $t4 → $t0 = 2 + 2 = 4
            add $t0, $t0, $t0 → $t0 = 4 + 4 = 8
            add $t1, $t0, $s6 → $t1 = 8 + 0 = 8
            lw $s1, 0($t1) → $s1 = MEM[8] = 59
            addi $s1, $s1, 10 → $s1 = 59 + 10 = 69
            sw $s1, 0($t1) → MEM[8] = 69
            addi $s0, $s0, 1 → $s0 = 2 + 1 = 3
            j 4 → Volta para I_MEM[4]

            continua até $t0 == 0     
           */

        end
    end 

endmodule