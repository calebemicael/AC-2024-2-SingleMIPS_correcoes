module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];

    // Inicialização da memória
    integer i;
    initial begin
        //memória inicializada com zero em todos em enderecos
        for (i = 0; i < 256; i = i + 1) begin
            memoria[i] = 32'b0;
        end
        // leitura de instruções do arquivo
        $readmemb("codigo.mem", memoria);// para ajudar o professor hehehe
        //instrução traduzida para teste: (Obs: não foram colocadas mais, pois a validaão virá a partir das entradas colocadas pelo professor)
        /*
        .text 
        main:
            add $t0, $t1, $t2
        j pulo
        pulo:
            sub $t3, $t4, $t5*/
        
    end
    
    //lendo a instrucão 
    assign instrucao = memoria[addr[9:2]]; 
endmodule
