module Control(
    input wire[5:0] OPcode,
    input wire zero,
    output wire RegDst,
    output wire Branch_and_zero_result,
    output wire MemRead,
    output wire MemtoReg,
    output wire MemWrite,
    output wire ALUSrc,
    output wire RegWrite,
    output wire[1:0] ALUOp,
    output wire Jump
);

wire r_format, lw, sw, beq;

assign r_format = !OPcode[5] & !OPcode[4] & !OPcode[3] & !OPcode[2] & !OPcode[1] & !OPcode[0];
assign lw = OPcode[5] & !OPcode[4] & !OPcode[3] & !OPcode[2] & OPcode[1] & OPcode[0];
assign sw = OPcode[5] & !OPcode[4] & OPcode[3] & !OPcode[2] & OPcode[1] & OPcode[0];
assign beq = !OPcode[5] & !OPcode[4] & !OPcode[3] & OPcode[2] & !OPcode[1] & !OPcode[0];

assign RegDst = r_format;
assign ALUSrc = lw | sw;
assign MemtoReg = lw;
assign RegWrite = r_format | lw;
assign MemRead = lw;
assign MemWrite = sw;
assign Branch_and_zero_result = beq & zero;
assign ALUOp[1] = r_format;
assign ALUOp[0] = beq;

assign Jump = OPcode == 6'b000010 ? 1 : 0;

endmodule