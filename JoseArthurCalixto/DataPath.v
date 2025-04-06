`include "Add4.v"
`include "MemoriaDeInstrucoes.v"
`include "Control.v"
`include "Mux5.v"
`include "Mux32.v"
`include "Registradores.v"
`include "SignalExtend.v"
`include "AluControl.v"
`include "ALU.v"
`include "DataMemory.v"
`include "ShiftLeft2.v"
`include "ShiftLeft2_26.v"

module DataPath(
    input wire clock,
    input wire reset
);

// REGS Memoria de instrucao

//reg clock,reset;
wire [31:0] inst;

// REGS ADD4

reg [31:0] pc;
wire [31:0] pc_incrementado;

// REGS R

wire [4:0] RRegister1;
wire [4:0] RRegister2;
wire [4:0] WRegister;
wire [31:0] RData1;
wire [31:0] RData2;

// REGS ALU R

wire [31:0] a;
wire [31:0] b;
wire [31:0] aluresult;
wire zero;

// MUX2

wire [31:0] saidaMux2;
wire [31:0] saidaMux3;

// CONTROL

wire [1:0] aluop;
wire regD,br,mr,mtreg,mw,asrc,rw,jump;

// REGS ALU CONTROL
wire [3:0] ula_regout;
wire [3:0] ula_out;

// DATA MEMORY 
wire [31:0] rdDM;

// Outros
wire [31:0] ExtSignal;

wire [31:0] out_sl2;

wire [31:0] alubeqresult;
wire beqzero;

wire and_result; 
wire [31:0] saidaMux4;
wire [31:0] saidaMux5;

wire [31:0] pc_mais_4;

Add4 add4 (
    .in(pc),
    .out(pc_incrementado)
);

MemoriaDeInstrucoes memoriadeinstrucoes (
    .addr(pc),
    .instrucao(inst)
);

Control controle (
    .OP(inst[31:26]),
    .RegDist(regD),
    .Branch(br),
    .MemRead(mr),
    .MemtoReg(mtreg),
    .MemWrite(mw),
    .ALUSrc(asrc),
    .RegWrite(rw),
    .Jump(jump),
    .ALUOp(aluop)
);

Mux5 mux1(
    .A(inst[20:16]),
    .B(inst[15:11]),
    .S(regD),
    .X(WRegister)
);

Registradores registradores (
    .clock(clock),
    .reset(reset),
    .ReadRegister1(inst[25:21]),
    .ReadRegister2(inst[20:16]),
    .WriteRegister(WRegister),
    .WriteData(saidaMux3),
    .RegWrite(rw),
    .ReadData1(RData1),
    .ReadData2(RData2)
);

SignalExtend signalextend(
    .in(inst[15:0]),
    .out(ExtSignal)
);

Mux32 mux2 (
    .A(RData2),
    .B(ExtSignal),
    .S(asrc),
    .X(saidaMux2)
);


AluControl controlealu (
    .ALUOperation(aluop),
    .funct(inst[5:0]),
    .regout(ula_regout),
    .out(ula_out)
);

ALU alu1 (
    .A(RData1),
    .B(saidaMux2),
    .ALUOperation(ula_out),
    .ALUResult(aluresult),
    .Zero(zero)
);

DataMemory datamemory (
    .clk(clock), 
    .MemRead(mr),
    .MemWrite(mw),
    .address(aluresult),
    .writeData(RData2),
    .readData(rdDM)
);

Mux32 mux3 (
    .A(aluresult),
    .B(rdDM),
    .S(mtreg),
    .X(saidaMux3)
);

ShiftLeft2 sl2 (
    .in(ExtSignal),
    .out(out_sl2)
);

ALU aluBEQ (
    .A(pc_incrementado),
    .B(out_sl2),
    .ALUOperation(4'b0010),
    .ALUResult(alubeqresult),
    .Zero(beqzero)
);

assign and_result = zero & br;

Mux32 mux4 (
    .A(pc_incrementado),
    .B(alubeqresult),
    .S(and_result),
    .X(saidaMux4)
);

ShiftLeft2_26 sl2_superior (
    .in(inst[25:0]),
    .pc_mais_4(pc_incrementado[31:28]),
    .out(pc_mais_4)
);

Mux32 mux5 (
    .A(saidaMux4),
    .B(pc_mais_4),
    .S(jump),
    .X(saidaMux5)
);

always @(posedge clock or posedge reset) begin
        pc <= saidaMux5;
        if (reset) begin
            pc <= 32'b0;      // Inicializa o PC no reset      
        end 
        else begin
            // Atualiza o PC com o próximo endereço
            pc <= pc_incrementado;  
        end
end
endmodule