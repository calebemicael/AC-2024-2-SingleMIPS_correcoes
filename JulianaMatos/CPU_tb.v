`timescale 1ns/1ps
//`include "CPU.v"
/*
`include "ALU.v"
`include "Registradores.v"
`include "SignalExtend.v"
`include "Adder32.v"
`include "ShiftLeft2.v"
`include "DataMemory.v"
`include "MemoriaDeInstrucoes.v"
`include "ALUControl.v"
`include "Add4.v"
`include "FetchUnit.v"
`include "ControlUnit.v"
`include "Decodificador.v"
`include "MUX.v"
*/

module testbench;
    reg clk;
    reg reset;

    CPU dut (
        .clk(clk),
        .reset(reset)
    );

    wire [31:0] instrucao, pc, next_pc, pcPlus4, branchAddress, jump_address;
    wire [31:0] ReadData1, ReadData2, mux3, ALUResult, data_mem_out, WriteData, alu_operand2;
    wire [31:0] signExtendedOffset, shiftedOffset;
    wire [4:0] WriteRegister, ReadRegister1, ReadRegister2;
    wire [1:0] ALUOp;
    wire [3:0] ALUOperation;
    wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, Zero, PCSrc;
    
/*
    FetchUnit fetch (
        .clk(clk), //input
        .reset(reset), //input
        .instrucao(instrucao) //out: MemoriaDeInstrucoes
    );

    MemoriaDeInstrucoes instr_mem (
        .addr(pc), //input: endereço da instrução vindo do pc
        .instrucao(instrucao) //out: ControlUnit, registradores, ALU, etc
    );

    ControlUnit control (
        .opcode(instrucao[31:26]), //input vindo da MemoriaDeInstrucoes
        .RegDst(RegDst), //out: MUX que escolhe o registrador destino
        .ALUSrc(ALUSrc), //out: MUX que seleciona o operando da ALU
        .MemToReg(MemToReg), //out: MUX que seleciona ALU ou DataMemory
        .Branch(Branch), //out: cálculo do beq
        .ALUOp(ALUOp), //out: ALU
        .MemRead(MemRead), //out: DataMemory
        .MemWrite(MemWrite), //out: DataMemory
        .RegWrite(RegWrite), //out: Registradores
        .Jump(Jump) //out: controle do jump
    ); 

    Registradores reg_file (
        .ReadRegister1(ReadRegister1), //input do ControlUnit(rs)
        .ReadRegister2(ReadRegister2), //input do ControlUnit(rt)
        .WriteRegister(WriteRegister), //input 
        .WriteData(WriteData),
        .RegWrite(RegWrite), //input 
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    SignExtend sign_ext (
        .in(instrucao[15:0]), //input vindo da instrucao(MemoriaDeInstrucoes)
        .out(signExtendedOffset) //out: ALU pelo mux
    );

    ALUControl alucontrol(
        .funct(instrucao[5:0]),
        .ALUOp(ALUOp),
        .ALUControlSignal(ALUOperation)
    );

    ALU alu (
        .A(ReadData1),
        .B(signExtendedOffset),
        .ALUOperation(4'b0010),
        .ALUResult(ALUResult), // out: DataMemory (cálculo de endereço) OU Registradores (cálculo aritmético)
        .Zero(Zero) //out: vai para o cálculo do branch
    );

    ShiftLeft2 shift_left (
        .in(signExtendedOffset), //input do SignalExtend
        .out(shiftedOffset) //out: Cálculo do PC
    );

    DataMemory data_mem (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(ReadData2),
        .readData(data_mem_out) //out: mux até o Registradores pro write back
    );

    Adder32 adder (
        .a(pcPlus4),
        .b(shiftedOffset),
        .sum(branchAddress)
    );

    assign PCSrc = Branch && Zero;

    MUX mux (
        //mux1
        .Adder32(branchAddress),
        .Add4(pcPlus4),
        .seletor1(PCSrc),
        .mux1(next_pc),

        //mux2
        .rt(instrucao[20:16]),
        .rd(instrucao[15:11]),
        .seletor2(RegDst),
        .mux2(WriteRegister),

        //mux3
        .ReadData2(ReadData2),
        .SignalExtend(signExtendedOffset),
        .seletor3(ALUSrc),
        .mux3(alu_operand2),

        //mux4
        .readData(data_mem_out),
        .ALUResult(ALUResult),
        .seletor4(MemToReg),
        .mux4(WriteData),

        //mux5
        //.mux1(next_pc),
        .jump_target(jump_address),
        .seletor5(Jump),
        .mux5(pc)
    );
*/
    always #5 clk = ~clk; 

    initial begin

        $dumpfile("cpu_waveform.vcd"); 
        $dumpvars(0, testbench);

        clk = 0;
        reset = 1;
        #10 reset = 0;

        #100;

        $finish;
    end

endmodule
