// Datapath MIPS Integrado
`include "PC.v"
`include "InstructionMemory.v"
`include "RegisterFile.v"
`include "ALU.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "MUX2to1.v"
`include "MUX2to1_5bit.v"
`include "ALUControl.v"
`include "SignExtend.v"
`include "Adder.v"
`include "ShiftLeft2.v"
`include "PC_MUX.v"

module MIPS_Datapath(clk, reset);
    input clk;
    input reset;

    // Sinal do PC
    wire [31:0] pc_current, pc_next, pc_plus_4, branch_address;

    // Sinal da Instrução
    wire [31:0] instruction;
    wire [5:0] opcode = instruction[31:26];
    wire [4:0] rs = instruction[25:21];
    wire [4:0] rt = instruction[20:16];
    wire [4:0] rd = instruction[15:11];
    wire [5:0] funct = instruction[5:0];
    wire [15:0] immediate = instruction[15:0];

    // Sinal da Unidade de Controle
    wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;

    // Sinal dos Registradores
    wire [31:0] read_data1, read_data2, write_data;

    // Sinal da ALU
    wire [3:0] ALU_Ctrl;
    wire [31:0] ALU_result, ALU_srcB;
    wire zero;

    // Extensão de sinal e deslocamento
    wire [31:0] sign_extended, shifted_immediate;

    // MUX
    wire [4:0] write_reg;
    wire [31:0] alu_src_mux_out, mem_to_reg_mux_out;

    // Instância dos módulos principais
    PC pc_reg(.clk(clk), .reset(reset), .pc_in(pc_next), .pc_out(pc_current));

    Adder pc_adder(.a(pc_current), .b(32'd4), .result(pc_plus_4));

    InstructionMemory instr_mem(.address(pc_current), .instruction(instruction));

    ControlUnit control(
        .opcode(opcode),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    MUX2to1_5bit reg_dst_mux(.in0(rt), .in1(rd), .sel(RegDst), .out(write_reg));

    RegisterFile reg_file(
        .clk(clk),
        .regWrite(RegWrite),
        .readReg1(rs),
        .readReg2(rt),
        .writeReg(write_reg),
        .writeData(write_data),
        .readData1(read_data1),
        .readData2(read_data2)
    );

    SignExtend sign_ext(.in(immediate), .out(sign_extended));

    MUX2to1 alu_src_mux(.in0(read_data2), .in1(sign_extended), .sel(ALUSrc), .out(ALU_srcB));

    ALUControl alu_control(.ALUOp(ALUOp), .funct(funct), .ALU_Ctrl(ALU_Ctrl));

    ALU alu(.input1(read_data1), .input2(ALU_srcB), .aluControl(ALU_Ctrl), .result(ALU_result), .zero(zero));

    DataMemory data_mem(
        .clk(clk),
        .address(ALU_result),
        .writeData(read_data2),
        .memRead(MemRead),
        .memWrite(MemWrite),
        .readData(mem_to_reg_mux_out)
    );

    MUX2to1 mem_to_reg_mux(.in0(ALU_result), .in1(mem_to_reg_mux_out), .sel(MemtoReg), .out(write_data));

    ShiftLeft2 shift_left_2(.in(sign_extended), .out(shifted_immediate));

    Adder branch_adder(.a(pc_plus_4), .b(shifted_immediate), .result(branch_address));

    PC_MUX pc_mux(.pc_plus_4(pc_plus_4), .branch_address(branch_address), .branch(Branch), .zero(zero), .next_pc(pc_next));
endmodule
