`include "MemoriaDeInstrucoes.v"

module MemoriaDeInstrucoes_tb();
    reg [31:0] addr;          
    wire [31:0] instrucao;   

    MemoriaDeInstrucoes rom (
        .addr(addr),
        .instrucao(instrucao)
    );

    initial begin
        addr = 0; 
        for (integer i = 0; i < 256; i = i + 4) begin
            #5 addr = i; 
        end
        $finish; 
    end

    initial begin
        $monitor("Tempo = %0t | Addr = %0d | Instrucao = %h", $time, addr, instrucao);
    end
endmodule
