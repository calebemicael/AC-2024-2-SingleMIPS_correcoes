module ALU_Control(
    input wire[1:0] ALUOp,
    input wire[5:0] instruction,
    output wire[3:0] ALUOperation
);

wire aux1, aux2, aux3;

or(aux1, instruction[0],instruction[3]);
and(ALUOperation[0], aux1, ALUOp[1]);

nand(ALUOperation[1], instruction[2], ALUOp[1]);
and(aux2, instruction[1], ALUOp[1]);
or(ALUOperation[2], aux2, ALUOp[0]);

not(aux3, ALUOp[0]);
and(ALUOperation[3], aux3, ALUOp[0]);
endmodule