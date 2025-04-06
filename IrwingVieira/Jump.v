module Jump(
    input [31:0] actualPC,
    input [25:0] jumpAddress,
    output [31:0] newPC
);
    wire [31:0] incrementedPC;
    wire [27:0] shiftedJump;
    
    //Move o endereço do jump duas casas à esquerda, tornando-o múltiplo de 4.
    assign shiftedJump = {jumpAddress, 2'b00};
    
    //Soma o contador atual por 4 para obter depois os seus 4 primeiros bits mais significativos.
    Add4 somaQuatro(.in(actualPC), .out(incrementedPC));
    
    //Concatena o que foi calculado e gera o novo program counter:
    assign newPC = {incrementedPC[31:28], shiftedJump};
endmodule