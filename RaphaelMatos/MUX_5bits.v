// usado para selecionar qual parte das intruções deverão entrar no write register
module MUX_5bits(
    input wire[4:0] in_1, // vindo do instruction[20:16]
    input wire[4:0] in_2, // vindo do instruction[15:11]
    input wire RegDst,
    output wire[4:0] out
);

assign out = RegDst ? in_2 : in_1;

 endmodule  