// usado para conectar os registradores ou sign-extend à ALU
module MUX_32bits_ALUSrc(
    input wire[31:0] ReadData2, 
    input wire[31:0] SignExtend, 
    input wire ALUSrc,
    output wire[31:0] out
);

assign out = ALUSrc ? SignExtend : ReadData2;

endmodule  