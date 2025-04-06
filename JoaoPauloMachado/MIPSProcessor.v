
module MIPSProcessor(
    input clk,
    input reset,
    output wire [31:0] result,
    output wire [31:0] instruction
);

    wire [31:0] signExtended, ReadData1, ReadData2, writeData;
    wire [31:0] secondALUOperand, ALUResult, shiftedLeft2, memoryReadData;
    wire [4:0] writeRegister;
    wire [1:0] ALUOp;
    wire [3:0] op;
    wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Zero;
    
    FetchUnit fetch_unit (
        .clk(clk),
        .reset(reset),
        .Branch(Branch),
        .zero(Zero),
        .offset(shiftedLeft2),
        .instrucao(instruction)
    );

    SignExtend SignExtend(
        .in(instruction[15:0]),
        .out(signExtended)
    );

    ControlUnit control_unit (
        .opcode(instruction[31:26]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    mux2x1_1 muxWriteRegister(
        .rdField(instruction[15:11]),
        .rtField(instruction[20:16]),
        .RegDst(RegDst),
        .out(writeRegister)
    );

    Registradores registers(
        .ReadRegister1(instruction[25:21]),
        .ReadRegister2(instruction[20:16]),
        .WriteRegister(writeRegister),
        .WriteData(writeData),
        .RegWrite(RegWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    ALUControl ALUControl(
        .funct(instruction[5:0]),
        .ALUOp(ALUOp),
        .op(op)
    );

    mux2x1_2 muxALU(
        .signExtended(signExtended),
        .dataRegister2(ReadData2),
        .ALUSrc(ALUSrc),
        .out(secondALUOperand)
    );

    ALU alu(
        .A(ReadData1),
        .B(secondALUOperand),
        .ALUOperation(op),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    ShiftLeft2 ShiftLeft2(
        .in(signExtended),
        .out(shiftedLeft2)
    );

    DataMemory dataMemory(
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(ReadData2),
        .readData(memoryReadData)
    );

    mux2x1 muxMemToReg(
        .ALUResult(ALUResult),
        .dataMemory(memoryReadData),
        .MemToReg(MemToReg),
        .out(writeData)
    );

    assign result = writeData;
endmodule
