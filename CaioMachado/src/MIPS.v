module MIPS (
    input clk,
    input reset,
    output [31:0] pc,
    output [31:0] instruction,
    output [31:0] alu_result,
    output [31:0] read_data
);
    // Sinais internos
    wire [31:0] next_pc;
    wire [31:0] sign_extended_imm;
    wire [31:0] alu_src_b;
    wire [31:0] reg_write_data;
    wire [4:0] reg_write_addr;
    wire [31:0] reg_data1, reg_data2;
    wire [3:0] alu_control;
    wire zero;

    // Sinais de controle
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [1:0] ALUOp;

    // Módulos
    ProgramCounter pc_reg (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    InstructionMemory imem (
        .address(pc),
        .instruction(instruction)
    );

    ControlUnit control (
        .opcode(instruction[31:26]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    RegisterFile reg_file (
        .clk(clk),
        .reg_write(RegWrite),
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .write_reg(reg_write_addr),
        .write_data(reg_write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    SignExtend sign_ext (
        .imm(instruction[15:0]),
        .sign_extended_imm(sign_extended_imm)
    );

    MUX2to1 #(5) mux_reg_dst (
        .in0(instruction[20:16]),
        .in1(instruction[15:11]),
        .sel(RegDst),
        .out(reg_write_addr)
    );

    MUX2to1 #(32) mux_alu_src (
        .in0(reg_data2),
        .in1(sign_extended_imm),
        .sel(ALUSrc),
        .out(alu_src_b)
    );

    ALUControl alu_control_unit (
        .funct(instruction[5:0]),
        .ALUOp(ALUOp),
        .alu_control(alu_control)
    );

    ALU alu (
        .srcA(reg_data1),
        .srcB(alu_src_b),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero(zero)
    );

    DataMemory data_mem (
        .clk(clk),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .address(alu_result),
        .write_data(reg_data2),
        .read_data(read_data)
    );

    MUX2to1 #(32) mux_mem_to_reg (
        .in0(alu_result),
        .in1(read_data),
        .sel(MemtoReg),
        .out(reg_write_data)
    );

    assign next_pc = pc + 4; // Próximo PC (sem desvio)
endmodule