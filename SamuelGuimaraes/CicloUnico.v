`include "UnidadeControle.v"
`include "ALU.v"
`include "ALUControl.v"
`include "Mux32b.v"
`include "Mux5b.v"
`include "Registradores.v"
`include "SignExtend.v"
`include "ShiftLeft2.v"
`include "DataMemory.v"

module CicloUnico(
    input wire [31:0] instrucao,
    input wire clk,
    output wire jump,
    output wire branch,
    output wire ALUZero,
    output wire [31:0] fetchInstrucao
);
    
    wire _jump;
    wire _regDst;
    wire _ALUSrc;
    wire _memtoReg;
    wire _regWrite;
    wire _memRead;
    wire _memWrite;
    wire _branch;
    wire _ALUOp1;
    wire _ALUOp0;

    UnidadeControle unidade_controle (
        .operacao(instrucao[31:26]),
        .jump(_jump),
        .regDst(_regDst),
        .ALUSrc(_ALUSrc),
        .memtoReg(_memtoReg),
        .regWrite(_regWrite),
        .memRead(_memRead),
        .memWrite(_memWrite),
        .branch(_branch),
        .ALUOp1(_ALUOp1),
        .ALUOp0(_ALUOp0)
    );

    wire [4:0] _mux0;
    Mux5b mux0 (
        .A(instrucao[20:16]),
        .B(instrucao[15:11]),
        .seletor(_regDst),
        .Y(_mux0)
    );

    wire [31:0] _readData1;
    wire [31:0] _readData2;

    Registradores registradores (
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(_mux0),
        .WriteData(_mux2),
        .RegWrite(_regWrite),
        .ReadData1(_readData1),
        .ReadData2(_readData2)
    );

    wire [31:0] _sign_extend;
    SignExtend sign_extend (
        .in(instrucao[15:0]),
        .out(_sign_extend)
    );

    wire [31:0] _mux1;
    Mux32b mux1 (
        .A(_readData2),
        .B(_sign_extend),
        .seletor(_ALUSrc),
        .Y(_mux1)
    );

    wire [3:0] _operacaoALU;
    ALUControl alu_control(
        .ALUOp1(_ALUOp1),
        .ALUOp0(_ALUOp0),
        .instrucao(instrucao[5:0]),
        .operacao(_operacaoALU)
    );

    wire [31:0] _ALUResult;
    wire _ALUZero;
    ALU alu (
        .A(_readData1),
        .B(_mux1),
        .ALUOperation(_operacaoALU),
        .ALUResult(_ALUResult),
        .Zero(_ALUZero)
    );

    wire [31:0] _readData;
    DataMemory data_memory (
        .clk(clk),
        .MemRead(_memRead),
        .MemWrite(_memWrite),
        .address(_ALUResult),
        .writeData(_readData2),
        .readData(_readData)
    );

    wire [31:0] _mux2;
    Mux32b mux2 (
        .A(_ALUResult),   //mux invertido
        .B(_readData),
        .seletor(_memtoReg),
        .Y(_mux2)
    );

    assign jump = _jump;
    assign fetchInstrucao = _sign_extend;
    assign branch = _branch;
    assign ALUZero = _ALUZero;

endmodule