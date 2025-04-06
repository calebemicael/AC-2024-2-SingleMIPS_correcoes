`include "FetchUnit.v"
`include "ControlUnit.v"
`include "Registradores.v"
`include "DataMemory.v"
`include "ALU.v"
`include "ALUControl.v"
`include "SignalExtend.v"
`include "Mux32bits.v"
`include "Add4.v"
`include "ShiftLeft2.v"
`include "Adder32.v"
`include "ShiftLeft25bits"

module Mips(
    input wire clk,
    input wire reset,
    output wire [31:0] result
);

wire regWrite, aluScr, regDst, memtoReg, memRead, branch, memWrite, jump;
wire [3:0] AluOperation;
wire [1:0] AluOp;
wire [4:0] writeRegister;
wire [31:0] writeData, readData1, readData2, instrucao, readData, SignalExtendOut, resultmux, shiftleftout, resultsum, pc_next, pc_next_final, pc_incrementado, pc;
wire zero;
wire[27:0] endereco_jump;
wire [31:0]jump_address;
assign jump_address = {pc_incrementado[31:28], endereco_jump};


FetchUnit unidade_Busca(
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next_final), 
    .pc(pc),
    .instrucao(instrucao),
    .pc_incrementado(pc_incrementado)
);


ControlUnit unidadeControle (
    .instrucao(instrucao[31:26]),
    .RegWrite(regWrite),
    .AluSCR(aluScr),
    .RegDst(regDst),
    .MemWrite(memWrite),
    .MemtoReg(memtoReg),
    .MemRead(memRead),
    .Branch(branch),
    .Jump(jump),
    .AluOp(AluOp)
);

Registradores banco_registradores (
    .ReadRegister1(instrucao[25:21]),
    .ReadRegister2(instrucao[20:16]),
    .WriteRegister(writeRegister),
    .WriteData(writeData),
    .RegWrite(regWrite),
    .ReadData1(readData1),
    .ReadData2(readData2)
);

DataMemory MemoriaData(
    .clk(clk),
    .MemRead(memRead),
    .MemWrite(memWrite),
    .address(result),
    .writeData(readData2),
    .readData(readData)
);

ALU alu(
    .A(readData1),
    .B(resultmux),
    .ALUOperation(AluOperation),
    .ALUResult(result),
    .Zero(zero)
);

ALUControl controle_ALu(
    .ALUOp(AluOp),
    .Funct(instrucao[5:0]),
    .ALUoperation(AluOperation)
);

SignExtend signalExt(
    .in(instrucao[15:0]),
    .out(SignalExtendOut)    
);

Mux #(.WIDTH(5)) mux2x1Reg(
    .A(instrucao[20:16]),
    .B(instrucao[15:11]),
    .sel(regDst),
    .out(writeRegister)
);

Mux #(.WIDTH(32))mux2x1ALU(
    .A(readData2),
    .B(SignalExtendOut),
    .sel(aluScr),
    .out(resultmux)
);

Mux #(.WIDTH(32)) mux2x1DataMemory(
    .A(result),
    .B(readData),
    .sel(memtoReg),
    .out(writeData)
);

Mux #(.WIDTH(32)) mux2x1ProxEndereco(
    .A(pc_incrementado),
    .B(resultsum),
    .sel(branch & zero),
    .out(pc_next)
);

Mux #(.WIDTH(32)) mux2x1Jump(
    .A(pc_next),
    .B(jump_address),
    .sel(jump),
    .out(pc_next_final)
);

ShiftLeft25bits shiftjump(
    .in(instrucao[25:0]),
    .out(endereco_jump)
);

ShiftLeft2 shiftleft(
    .in(SignalExtendOut),
    .out(shiftleftout)
);

Adder32 add(
    .a(pc_incrementado),
    .b(shiftleftout),
    .sum(resultsum)
);
endmodule