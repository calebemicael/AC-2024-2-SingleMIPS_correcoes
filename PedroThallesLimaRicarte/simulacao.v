`timescale 1ns/1ns
`include "Add4.v"
`include "Adder32.v"
`include "ALU.v"
`include "ALUControl.v"
`include "And.v"
`include "Control.v"
`include "DataMemory.v"
`include "MemoriaDeInstrucoes.v"
`include "MUX_ALUSrc.v"
`include "MUX_MemtoReg.v"
`include "MUX_PCSrc.v"
`include "MUX_RegDst.v"
`include "PC.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"
`include "muxJump.v"
`include "shiftleftJump.v"

module simulacao;


reg clk;
reg reset;
wire [31:0] inPC;
wire [31:0] programCounter;
wire [31:0] PCP4;
wire [31:0] addResult;
wire [31:0] instruction;
wire [31:0] WriteData;
wire [31:0] ReadData1;
wire [31:0] ReadData2;
wire [31:0] SignExtend;
wire [4:0] MuxReg;
wire [31:0] ReadData;
wire [31:0] ALUResult;
wire [31:0] ShiftLeft;
wire RegDst;
wire Jump;
wire Branch;
wire MemtoReg;
wire MemRead;
wire zzero;
wire [31:0] doisOp;
wire [1:0] ALUOp;
wire [3:0] ALUC;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire andResult;
wire [27:0] ShiftVinteOito;
wire [31:0] JumpAddress;
wire [31:0] attPC;



PC Pc(
    .clk(clk),
    .reset(reset),
    .addrValue(attPC),
    .address(programCounter)
);

MemoriaDeInstrucoes instMemory (
    .addr(programCounter),
    .instrucao(instruction)
);

MUX_RegDst muxreg (
    .SecOperand(instruction[20:16]),
    .Destiny(instruction[15:11]),
    .RegDst(RegDst),
    .WriteRegister(MuxReg)
);

Control control(
    .OP(instruction[31:26]),
    .ALUOp(ALUOp),
    .RegDst(RegDst),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Jump(Jump)
);

Add4 add4(
    .in(programCounter),
    .out(PCP4)
);

Registradores registradores (
    .clk(clk),
    .reset(reset),
    .ReadRegister1(instruction[25:21]),
    .ReadRegister2(instruction[20:16]),
    .WriteRegister(MuxReg),
    .WriteData(WriteData),
    .RegWrite(RegWrite),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

SignalExtend signalExtend (
    .in(instruction[15:0]),
    .out(SignExtend)
);

ALUControl alucontrol (
    .funct(instruction[5:0]),
    .AluOp(ALUOp),
    .ALUC(ALUC)

);

MUX_ALUSrc muxalu (
    .ReadReg(ReadData2),
    .SignEx(SignExtend),
    .ALUSrc(ALUSrc),
    .Operand(doisOp)

);

ALU alu(
    .A(ReadData1),
    .B(doisOp),
    .ALUOperation(ALUC),
    .ALUResult(ALUResult),
    .Zero(zzero)
);

DataMemory datamemory(
    .clk(clk),
    .reset(reset),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .address(ALUResult),
    .writeData(ReadData2),
    .readData(ReadData)
);

MUX_MemtoReg muxmem(
    .ReadData(ReadData),
    .ALUResult(ALUResult),
    .MemtoReg(MemtoReg),
    .WriteData(WriteData)
);

ShiftLeft2 shiftLeft (
    .in(SignExtend),
    .out(ShiftLeft)
);

Adder32 adder32 (
    .a(PCP4),
    .b(ShiftLeft),
    .sum(addResult)
);

MUX_PCSrc muxPCSrc(
    .pc_4(PCP4),
    .sum(addResult),
    .PCSrc(andResult),
    .programAddr(inPC)
);

And ande (
    .Branch(Branch),
    .zzero(zzero),
    .PCSrc(andResult)   
);

shiftleftJump shiftleftjump (
    .in(instruction[25:0]),
    .out(ShiftVinteOito)
); 

assign JumpAddress = {PCP4[31:28] , ShiftVinteOito};

muxJump muxjump (
    .JumpAddress(JumpAddress),
    .NoJump(inPC),
    .Jump(Jump),
    .attPC(attPC)
);


integer i;

always #5 clk = ~clk;

initial begin
        $dumpfile("mips.vcd"); 
        $dumpvars(0, simulacao);


        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, simulacao.registradores.registers[i]); 
        end

        for (i = 0; i < 256; i = i + 1) begin
            $dumpvars(1, simulacao.datamemory.memory[i]); 
        end


        clk = 0;
        reset = 0;
        #10
        reset = 1;
        #10
        reset = 0;
        #1000;
        $finish;
    end

    always @(posedge clk) begin
        $display("TEMPO: %d, clk: %b, reset: %b, PC: %d, Instrucao: %h",$time, clk, reset, Pc.pc, instruction);
    end 

    


endmodule