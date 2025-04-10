`include "ALU.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "InstructionMemory.v"
`include "MuxALUSrc.v"
`include "MuxJump.v"
`include "MuxMemToReg.v"
`include "MuxPCSrc.v"
`include "MuxRegDst.v"
`include "Registradores.v"

module MIPS(
    input wire clk,
    input wire reset
);

    // Sinais de controle
    wire RegWrite, ALUSrc, MemWrite, MemRead, Branch, Jump, MemToReg, RegDst;
    wire [3:0] ALUOperation;

    // Sinais de dados
    wire [31:0] PCValue, NextPC, FinalPC, Instruction, ReadData1, ReadData2, ALUResult, WriteData, SignExtended, BranchAddress, JumpAddress;
    wire Zero;
    wire [4:0] WriteRegister;
    wire [31:0] ALUInputB;
    wire [31:0] PCPlus4;

    // Cálculos intermediários
    assign PCPlus4 = PCValue + 4;  // Próximo endereço sequencial
    assign BranchAddress = PCPlus4 + (SignExtended << 2);  // Endereço de branch
    assign JumpAddress = {PCValue[31:28], Instruction[25:0], 2'b00};  // Endereço de jump

    // Instâncias dos módulos
    PC pc (.clk(clk), .reset(reset), .nextPC(NextPC), .jump(Jump), .jumpAddress(JumpAddress), .PCValue(PCValue)); // cade esse modulo?
    InstructionMemory imem (.Address(PCValue), .Instruction(Instruction));
    ControlUnit control (.opcode(Instruction[31:26]), .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite), .MemRead(MemRead), .Branch(Branch), .Jump(Jump), .MemToReg(MemToReg), .RegDst(RegDst), .ALUOperation(ALUOperation));
    MuxRegDst muxRegDst (.rt(Instruction[20:16]), .rd(Instruction[15:11]), .RegDst(RegDst), .WriteRegister(WriteRegister));
    Registradores regfile (.ReadRegister1(Instruction[25:21]), .ReadRegister2(Instruction[20:16]), .WriteRegister(WriteRegister), .WriteData(WriteData), .RegWrite(RegWrite), .ReadData1(ReadData1), .ReadData2(ReadData2));
    SignExtend signExtend (.immediate(Instruction[15:0]), .SignExtended(SignExtended));
    MuxALUSrc muxALUSrc (.ReadData2(ReadData2), .SignExtended(SignExtended), .ALUSrc(ALUSrc), .ALUInputB(ALUInputB));
    ALU alu (.A(ReadData1), .B(ALUInputB), .ALUOperation(ALUOperation), .ALUResult(ALUResult), .Zero(Zero));
    DataMemory dmem (.clk(clk), .Address(ALUResult), .WriteData(ReadData2), .MemWrite(MemWrite), .MemRead(MemRead), .ReadData(ReadData));
    MuxMemToReg muxMemToReg (.ALUResult(ALUResult), .ReadData(ReadData), .MemToReg(MemToReg), .WriteData(WriteData));
    MuxPCSrc muxPCSrc (.PCPlus4(PCPlus4), .BranchAddress(BranchAddress), .Branch(Branch), .Zero(Zero), .NextPC(NextPC));
    MuxJump muxJump (.NextPC(NextPC), .JumpAddress(JumpAddress), .Jump(Jump), .FinalPC(FinalPC));

endmodule