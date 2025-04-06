`include "UnidControle.v"
`include "MultiplexadorALUScr.v"
`include "MultiplexadorRegDest.v"

module CPU (
    input wire [5:0] opcode,         // opcode da instrução
    input wire [31:0] ReadData2,     // Dado de leitura do registrador
    input wire [31:0] Immediate,     // Valor imediato da instrução
    output wire [31:0] ALUInput2,    // Saída para o segundo operando da ALU
    input wire [4:0] Rt,             // Campo rt da instrução
    input wire [4:0] Rd,             // Campo rd da instrução
    output wire [4:0] RegWriteAddr   // Saída para o registrador de destino
);

    // Sinais de controle da unidade de controle
    wire RegWrite, ALUSrc, MemRead, MemWrite, RegDst, MemtoReg;
    wire [1:0] ALUOp;

    // Instância da unidade de controle
    UnidadeControle control_unit (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .RegDst(RegDst),
        .ALUOp(ALUOp)
    );

    // Multiplexador de ALUSrc (decide entre ReadData2 e Immediate)
    MUX2to1_ALUSrc mux_ALUSrc (
        .ReadData2(ReadData2),
        .Immediate(Immediate),
        .ALUSrc(ALUSrc),
        .ALUInput2(ALUInput2)   // Saída para o segundo operando da ALU
    );

    // Multiplexador de RegDst (decide entre Rt e Rd para o destino do registrador)
    MUX2to1_RegDst mux_RegDst (
        .Rt(Rt),
        .Rd(Rd),
        .RegDst(RegDst),
        .RegWriteAddr(RegWriteAddr)  // Saída para o registrador de destino
    );

endmodule
