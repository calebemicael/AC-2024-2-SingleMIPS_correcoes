module inst_memory (address, inst);
    input [31:0] address; 
    output [31:0] inst; //instrucao

    reg[31:0] memoria [255:0];
    integer k;
    initial begin
        $readmemh("repeticao.mem", memoria); //ler aqruivo com instrucoes binarias
    end
    assign inst = memoria [address[9:2]]; //indexa usando do 9 ao 2 bits

endmodule