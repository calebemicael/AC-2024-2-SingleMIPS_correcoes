`include "AddALU.v"
`include"ALU.v"
`include "ALUcontrol.v"
`include "ControlUnit.v"
`include"DataMemory.v"
`include"FetchUnit.v"
`include"Multiplexer.v"
`include"Registers.v"
`include "ShiftLeft28bits.v"
`include "ShiftLeft32bits.v"
`include"SignalExtend.v"

module MIPS(
    input wire clk,
    input wire reset
);

//Control signals
    wire regDst;
    wire jump;
    wire branch;
    wire memRead;
    wire memToReg;
    wire [1:0] ALUop;
    wire memWrite;
    wire ALUsource;
    wire regWrite;
    wire ALUzero; //from ALU
    wire PCsource; //and ALUzero branch
    wire [3:0] ALUcontrolWire;
    wire andBranchZero;

//Data signals
    wire [31:0] instruction;
    wire [31:0] signExtended;
    wire [31:0] readData1;
    wire [31:0] readData2;
    wire [31:0] ALUresult;
    wire [31:0] readDataMem;
    wire [4:0] selectedWrite; //result from write reg mux
    wire [31:0] ALUsecondOperand;
    wire [31:0] writeDataWire;
    wire [31:0] beqShiftWire;
    wire [31:0] addALUresult;    
    wire [27:0] jumpAdress;
    wire [31:0] addALUmuxResult;
    wire [31:0] nextInstruction;
    wire [31:0] incrementedPc;

    FetchUnit fetchUnit(
        .clk(clk),
        .reset(reset),
        .nextInstruction(nextInstruction),
        .instruction(instruction),
        .incrementedPc(incrementedPc)
    );

    ControlUnit control(
        .opCode(instruction[31:26]),
        .regDst(regDst),
        .jump(jump),
        .branch(branch),
        .memRead(memRead),
        .memToReg(memToReg),
        .ALUop(ALUop),
        .memWrite(memWrite),
        .ALUsource(ALUsource),
        .regWrite(regWrite)
    );

    Mux5 muxWriteReg(
        .in1(instruction[15:11]),
        .in2(instruction[20:16]),
        .s(regDst),
        .out(selectedWrite)
    );

    Registers registers(
        .readRegister1(instruction[25:21]),
        .readRegister2(instruction[20:16]),
        .writeRegister(selectedWrite),
        .writeData(writeDataWire),
        .regWrite(regWrite),
        .readData1(readData1),
        .readData2(readData2)
    );

    SignExtend signExtender(
        .in(instruction[15:0]),
        .out(signExtended)
    );

    ALUcontrol aluControl(
        .funct(instruction[5:0]),
        .ALUop(ALUop),
        .ALUcontrol(ALUcontrolWire)
    );

    Mux32 muxALUoperand(
        .in1(signExtended),
        .in2(readData2),
        .s(ALUsource),
        .out(ALUsecondOperand)
    );

    ALU alu(
        .operand1(readData1),
        .operand2(ALUsecondOperand),
        .ALUoperation(ALUcontrolWire),
        .ALUresult(ALUresult),
        .zero(ALUzero)
    );

    DataMemory dataMemory(
        .clk(clk),
        .memRead(memRead),
        .memWrite(memWrite),
        .address(ALUresult),
        .writeData(readData2),
        .readData(readDataMem)
    );

    Mux32 muxMemRead(
        .in1(readDataMem),
        .in2(ALUresult),
        .s(memToReg),
        .out(writeDataWire)
    );

    shiftLeft32 beqFetch(
        .in(signExtended),
        .out(beqShiftWire)
    );

    addALU addAlu(
        .in1(beqShiftWire),
        .in2(incrementedPc),
        .out(addALUresult)
    );

    assign andBranchZero = ALUzero & branch;

    Mux32 muxInstruction(
        .in1(addALUresult),
        .in2(incrementedPc),
        .s(andBranchZero),
        .out(addALUmuxResult)
    );

    shiftLeft28 jumpShift(
        .in(instruction[25:0]),
        .out(jumpAdress)
    );

    Mux32 muxJump(
        .in1({incrementedPc[31:28], jumpAdress}),
        .in2(addALUmuxResult),
        .s(jump),
        .out(nextInstruction)
    );
endmodule

