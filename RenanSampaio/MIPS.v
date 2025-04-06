module MIPS(
    input wire clk,
    input wire reset
);

    // fios para conexão entre módulos
    wire [31:0] pc;
    wire [31:0] nextPc;
    wire [31:0] add4out;
    wire [31:0] shiftLeft2Out;
    wire [31:0] add32Result;
    wire [31:0] aluResult;
    wire [31:0] instrucao;
    wire [31:0] ReadData1, ReadData2;   
    wire [31:0] writeData;
    wire [31:0] signExtendOut;
    wire [31:0] muxALUOut;
    wire [31:0] muxMemOut;
    wire [31:0] muxAddOut;
    wire [31:0] dataMemoryOut;
    wire [4:0] muxRegDstOut;
    wire [1:0] aluOp;
    wire [3:0] aluControlSignal;
    wire zero;
    wire regDst, branch, memRead, memtoReg, memWrite, aluSrc, regWrite;

    // instanciando módulos

    MemoriaDeInstrucoes memoriaInstrucoes (
        .addr(pc),
        .instrucao(instrucao)
    );

    PC pcModulo (
        .clk(clk),
        .reset(reset),
        .nextPc(nextPc),
        .pc(pc)
    );

    //FetchUnit fetch (
    //    .clk(clk),
    //    .reset(reset),
    //    .instrucao(instrucao)
    //);

    Mux2pra1com5b muxRegDst (
        .in0(instrucao[20:16]),
        .in1(instrucao[15:11]),
        .seletor(RegDst),
        .out(muxRegDstOut)
    );

    Registradores regModulo (
        .ReadRegister1(instrucao[25:21]),   // ReadRegister1 = rs
        .ReadRegister2(instrucao[20:16]),   // ReadRegister2 = rt 
        .WriteRegister(muxRegDstOut),   // WriteRegister = rd
        .WriteData(writeData),
        .RegWrite(regWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    SignExtend signExt(
        .in(instrucao[15:0]),
        .out(signExtendOut)
    );

    Mux2pra1 muxALU (
        .in0(ReadData2),
        .in1(signExtendOut),
        .seletor(aluSrc),
        .out(muxALUOut)
    );

    ALU alu ( 
        .A(ReadData1),
        .B(muxALUOut),
        .ALUOperation(aluControlSignal),
        .ALUResult(aluResult),
        .Zero(zero)
    );

    assign nextPc = muxAddOut;

    ALUControl aluControl (
        .ALUOp(aluOp),
        .funct(instrucao[5:0]),
        .ALUControl(aluControlSignal)
    );

    ControlUnit control (
        .Op(instrucao[31:26]),
        .RegDst(regDst),
        .Branch(branch),
        .MemRead(memRead),
        .MemtoReg(memtoReg),
        .ALUOp(aluOp),
        .MemWrite(memWrite),
        .ALUSrc(aluSrc),
        .RegWrite(regWrite)
    );

    DataMemory dataMem (
        .clk(clk),
        .MemRead(memRead),
        .MemWrite(memWrite),
        .address(aluResult),
        .writeData(ReadData2),
        .readData(dataMemoryOut)
    );

    Mux2pra1 muxMem (
        .in0(aluResult),
        .in1(dataMemoryOut),
        .seletor(memtoReg),
        .out(writeData)
    );

    Add4 add4(
        .in(pc),
        .out(add4out)
    );

    ShiftLeft2 shiftLeft2 (
        .in(signExtendOut),
        .out(shiftLeft2Out)
    );

    Adder32 adder (
        .a(add4out),
        .b(shiftLeft2Out),
        .sum(add32Result)
    );

    Mux2pra1 muxAdd (
        .in0(add4out),
        .in1(add32Result),
        .seletor(branch & zero),
        .out(muxAddOut)
    );

endmodule
    
