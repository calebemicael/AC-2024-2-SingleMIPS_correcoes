module MemoriaDeInstrucoes(
    input wire [31:0] addr,      
    output wire [31:0] instrucao
);


    reg [31:0] memoria [0:255];

    integer i;  

    initial begin

        $readmemb("programa.bin", memoria);
        $display("Memória carregada:");
        
        for (i = 0; i < 20; i = i + 1) begin
            $display("Instrucao[%0d] = %h", i, memoria[i]);
        end
    end


    assign instrucao = memoria[addr[31:2]];
endmodule