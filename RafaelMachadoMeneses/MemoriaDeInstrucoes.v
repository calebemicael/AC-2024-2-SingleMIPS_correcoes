module MemoriaDeInstrucoes(
    input wire [31:0] addr,
    output wire [31:0] instrucao
);
    reg [31:0] memoria [255:0];

    initial begin
        $readmemh("programa.mem", memoria); 
    end

    assign instrucao = memoria[addr[9:2]];
endmodule