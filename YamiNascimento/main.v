`include "ULA.v"
`include "sum4b.v"
`include "sum32b.v"
`include "control_unit.v"
`include "data_memory.v"
`include "mux32_5.v"
`include "instruction_memory.v"
`include "regs.v"
`include "sll2.v"
`include "signal_extend.v"
`include "ULAcontrol.v"
`include "fetch_module.v"

module main(clock, reset);
    input clock;
    input reset;

    wire [31:0] inst;
    wire [31:0] mux_write_data;
    wire [31:0] registerReaded1;
    wire [31:0] registerReaded2;
    wire [31:0] mux_alu;
    wire [31:0] result_ula;
    wire [31:0] extended_address;
    wire [31:0] readData;
    wire [31:0] shifted_extended;
    wire [4:0] mux_registor_destiny;
    wire [3:0] ALUOperation;
    wire [1:0] ALUOp;
    wire RegDst;
    wire Branch;
    wire MemRead;
    wire MemtoREG;
    wire RegWrite;
    wire MemWrite;
    wire ALUSrc;
    wire Zero;
    wire branch_result;


//instaciamento de todos modulos para single-cycle (no jump)
    fetch fetch(
        .clock(clock),
        .reset(reset),
        .branch(branch_result),
        .addr_extended(shifted_extended),
        .inst(inst)
    );

    unidade_controle ucontrole(
        .selector(inst[31:26]),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoREG(MemtoREG),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

    mux5b m1(
        .a(inst[20:16]),
        .b(inst[15:11]),
        .selector(RegDst),
        .out(mux_registor_destiny)
    );

    mux32b m2(
        .a(result_ula),
        .b(readData),
        .selector(MemtoREG),
        .out(mux_write_data)
    );
    
    mux32b m3(
        .a(registerReaded2),
        .b(extended_address),
        .selector(ALUSrc),
        .out(mux_alu)
    );

    signal_extend extender(
        .in(inst[15:0]),
        .out(extended_address)
    );

    registers regs(
        .ReadRegister1(inst[25:21]),
        .ReadRegister2(inst[20:16]),
        .WriteRegister(mux_registor_destiny),
        .WriteData(mux_write_data),
        .RegWrite(RegWrite),
        .clock(clock),
        .ReadData1(registerReaded1),
        .ReadData2(registerReaded2)
    );

    ULA alu(
        .A(registerReaded1),
        .B(mux_alu),
        .ALUOperation(ALUOperation),
        .result_ula(result_ula),
        .Zero(Zero)
    );

    ULAcontrole alucontrol(
        .ALUOp(ALUOp),
        .funct(inst[5:0]),
        .ALUOperation(ALUOperation)
    );

    data_memory dmemory(
        .clock(clock),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(result_ula),
        .writeData(registerReaded2),
        .readData(readData)
    );

    sll2 shifterl2(
        .in(extended_address),
        .out(shifted_extended)
    );

    assign branch_result = Branch & Zero;

endmodule
