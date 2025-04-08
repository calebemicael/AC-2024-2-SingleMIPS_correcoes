module Proc(
    input wire clk,
    input wire reset
);

//Sinais da UnidadeDeControle conforme o Livro
wire RegDst, BranchandZero, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0]ALUOp;
wire[31:0] instrucao;
wire[31:0] pcPlus4;
wire[31:0] writeData;
wire[31:0] readData1;
wire[31:0] readData2;
wire[31:0] signExtended;
wire[31:0] operandoB;
wire[31:0] ALUResult;
wire[31:0] dataMemoryReadData;
wire[31:0] resultShiftLeft;
wire[31:0] resultadoAddALU;
wire[31:0] branch_result;
wire[31:0] endJump;
wire[31:0] resultadoJump;
wire[27:0] shiftlLeftJump;
wire[4:0] writeRegister;
wire[3:0] alu_operation;
wire zero;
wire jump;

UnidadeDeControle u_controle(
    .OPcode(instrucao[31:26]),
    .zero(zero),
    .RegDst(RegDst),
    .BranchandZero(BranchandZero),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp),
    .Jump(jump)
);

FetchUnit fUnit(
    .clk(clk),
    .reset(reset),
    .pcPlus4(pcPlus4),
    .proxInstrucao(resultadoJump), 
    .instrucao(instrucao)
);

//multiplexação da saida da memória de intrução para a entrada no campo writeRegister do banco de regs
assign writeRegister = RegDst ? instrucao[15:11] : instrucao[20:16];

Registradores registradores(
    .clk(clk),
    .ReadRegister1(instrucao[25:21]),
    .ReadRegister2(instrucao[20:16]),
    .WriteRegister(writeRegister), 
    .WriteData(writeData), 
    .RegWrite(RegWrite), 
    .ReadData1(readData1),
    .ReadData2(readData2)
);

SignalExtend extensor_bits(
    .in(instrucao[15:0]),
    .out(signExtended)
);

//entrada do segundo operando. deicide se será do bando de registradores ou do imediato extendido
assign operandoB = ALUSrc ? signExtended : readData2;

ulaControle ula_Ctrl(
    .instrucao(instrucao[5:0]),
    .ALUOp(ALUOp), 
    .ALUOperation(alu_operation)
);

ALU alu(
    .A(readData1),
    .B(operandoB),
    .ALUOperation(alu_operation),
    .ALUResult(ALUResult),
    .Zero(zero)
);

DataMemory dMemory(
    .Clk(clk),
    .MemRead(MemRead), 
    .MemWrite(MemWrite), 
    .address(ALUResult),
    .writeData(readData2),
    .readData(dataMemoryReadData)
);


assign writeData = MemtoReg ? dataMemoryReadData : ALUResult;


ShiftLeft2 shift_left(
    .in(signExtended),
    .out(resultShiftLeft)
);

Adder32 adder_32(
    .a(pcPlus4), 
    .b(resultShiftLeft),
    .sum(resultadoAddALU)
);


//decide o valor do próximo endereco com base no Brandc & Zero
assign branch_result = BranchandZero ?  resultadoAddALU : pcPlus4;

ShiftLeft2J shiftleft2jump(
    .in(instrucao[25:0]),
    .out(shiftlLeftJump) 
);

concatenarEndJump concat(
    .A(shiftlLeftJump),
    .B(pcPlus4[31:28]), //$bits mais sigin do pc
    .out(endJump)
);


assign resultadoJump = jump ? endJump : branch_result;

endmodule