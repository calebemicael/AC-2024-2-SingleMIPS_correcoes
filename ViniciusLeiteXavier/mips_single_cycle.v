`include "adder32.v"
`include "alu.v"
`include "aluControl.v"
`include "control_unit.v"
`include "data_memory.v"
`include "fetchUnit.v"
`include "file_registers.v"
`include "jumpAddressCalc.v"
`include "mux_adder32.v"
`include "mux_alu.v"
`include "mux_dataMem.v"
`include "mux_jump.v"
`include "mux_registers.v"
`include "PC.v"
`include "shiftLeft2.v"
`include "signal_extend.v"

module mips_single_cycle(
    input clk,
    input reset
);

    wire [31:0] next_pc, instruction_PC, instruction_fetch_unit, instruction_jump_calc, mux_dataMem_write_data, readData1, readData2, signExtended_offset;
    wire [31:0] mux_alu_result_alu_B, ALU_result, readData, shiftLeft2_signExtended_offset, added4_instruction4, adder32_result, mux_adder32_result;
    wire [1:0] ALUop;
    wire regDst, jump, branch, memRead, memToReg, memWrite, aluSrc, regWrite; // Outputs da unidade de controle
    wire Zero, and_zero_branch; 
    wire [4:0] instruction_mux_register;
    wire [2:0] ALU_operation;

    pc pc (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(instruction_PC)
    );

    inst_memory instMem (
        .address(instruction_PC),
        .instruction(instruction_fetch_unit)
    );

    adder4 adder4 (
        .in(instruction_PC),
        .out(added4_instruction4)
    );

    // Unidade que calcula o endereço da instrução tipo jump
    jumpAddressCalc jumpAddress (
        .PC(added4_instruction4),
        .immediate(instruction_fetch_unit[25:0]),
        .jumpAddress(instruction_jump_calc)
    );

    control_unit controlunit(
        .opCode(instruction_fetch_unit[31:26]), // opcode da instrução buscada
        .regDst(regDst),
        .aluSrc(aluSrc),
        .memToReg(memToReg),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .branch(branch),
        .ALUop(ALUop),
        .jump(jump)
    );

    mux_registers muxRegisters(
        .instruction1(instruction_fetch_unit[20:16]),
        .instruction2(instruction_fetch_unit[15:11]),
        .regDst(regDst),
        .result(instruction_mux_register)
    );

    file_registers fileRegisters (
        .readRegister1(instruction_fetch_unit[25:21]),
        .readRegister2(instruction_fetch_unit[20:16]),
        .writeRegister(instruction_mux_register),
        .writeData(mux_dataMem_write_data), // criar essa variavel
        .regWrite(regWrite),
        .readData1(readData1),
        .readData2(readData2)
    );

    signal_extend singnExtend (
        .in(instruction_fetch_unit[15:0]),
        .out(signExtended_offset)
    );

    aluControl aluControl (
        .ALUop(ALUop),
        .funct(instruction_fetch_unit[5:0]),
        .result(ALU_operation)
    ); 

    mux_alu muxALU (
        .readData2(readData2),
        .signal_extend(signExtended_offset),
        .aluSrc(aluSrc),
        .result(mux_alu_result_alu_B)
    );

    alu alu(
        .A(readData1),
        .B(mux_alu_result_alu_B),
        .operation(ALU_operation),
        .result(ALU_result),
        .Zero(Zero)
    );

    data_memory dataMem (
        .clk(clk),
        .memRead(memRead),
        .memWrite(memWrite),
        .address(ALU_result),
        .writeData(readData2),
        .readData(readData)
    );

    mux_dataMem muxDataMem(
        .readData(readData),
        .ALU_result(ALU_result),
        .memtoReg(memToReg),
        .result(mux_dataMem_write_data)
    );

    shiftLeft2 shiftLeft2 (
        .in(signExtended_offset),
        .out(shiftLeft2_signExtended_offset)
    );

    adder32 adder32 (
        .a(added4_instruction4),
        .b(shiftLeft2_signExtended_offset),
        .sum(adder32_result)
    );

    and(and_zero_branch, Zero, branch);

    mux_adder32 muxAdder32 (
        .adder_result(added4_instruction4),
        .adder32_result(adder32_result),
        .and_zero_branch(and_zero_branch),
        .result(mux_adder32_result)
    );

    mux_jump muxJump (
        .jumpAddress(instruction_jump_calc),
        .usual_instruction(mux_adder32_result),
        .jump(jump),
        .result(next_pc)
    );

endmodule