`timescale 1ns/1ns 
`include "SignalExtend.v"
`include "ShiftLeft2.v"
`include "Registradores.v"
`include "Mux5bits.v"
`include "Mux.v"
`include "MemoriaDeInstrucoes.v"
`include "FetchUnit.v"
`include "DataMemory.v"
`include "Control.v"
`include "ALU.v"
`include "adder32.v"
`include "add4.v"

module simulacao;
    reg clk;
    reg reset;
    wire [31:0] instrucao;
    wire [31:0] pc;

    //wire [4:0] ReadRegister1,  // Endereço do registrador para leitura 1
    //wire [4:0] ReadRegister2,   Endereço do registrador para leitura 2
    wire [4:0] WriteRegister;  // Endereço do registrador para escrita
    wire [31:0] WriteData;     // Dados a serem escritos
    wire RegWrite;             // Habilitação de escrita
    wire [31:0] ReadData1;    // Dados lidos do registrador 1
    wire [31:0] ReadData2;     // Dados lidos do registrador 2

    wire [5:0] Opcode;
    wire [5:0] Funct;
    wire zero; //
    wire MemtoReg; 
    wire MemWrite; //
    wire Branch; //
    wire [3:0] ALUcontrol; //
    wire ALUSrc; //
    wire RegDst; //
    //wire RegWrite, //
    wire PCSrc; //

    wire [31:0] singimm;

    wire [31:0] singimmx4;

    wire [31:0] pcPlus4;

    wire [31:0] PCBranch;

    wire [31:0] pcI;

    wire [31:0] ALUResult;
    wire Zero;

    wire [31:0] srcB;

    wire [31:0] readData;
    
    FetchUnit unidade_fetch (
        .clk(clk),
        .reset(reset),
        .instrucao(instrucao),
        .pcI(pcI),
        .pcOut(pc)
    );

    controlUnit control_unit (
        .Opcode(instrucao[31:26]),
        .Funct(instrucao[5:0]),
        .zero(zero),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUcontrol(ALUcontrol),
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .PCSrc(PCSrc)
    );

    Mux5bits mux5bits_unit (
        .A(instrucao[15:11]),
        .B(instrucao[20:16]),
        .s(RegDst),
        .r(WriteRegister)
    );

    Registradores reg_unit(
        .clk(clk),
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]), 
        .WriteRegister(WriteRegister),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    SignExtend extend_unit (
        .in(instrucao[15:0]),
        .out(singimm)
    );

    ShiftLeft2 sift_unit (
        .in(singimm),
        .out(singimmx4)
    );

    Adder32 adder32_unit (
        .a(pc),
        .b(4),
        .sum(pcPlus4)
    );

    Adder32 adder32_unit2 (
        .a(singimmx4),
        .b(pcPlus4),
        .sum(PCBranch)
    );

    //Mux mux_unit2 (
    //    .A(PCBranch),
    //    .B(pcPlus4),
    //    .s(PCSrc),
    //    .r(pcI)
    //);

    assign pcI = PCSrc ? PCBranch : pcPlus4;

    ALU alu_unit (
        .A(ReadData1),
        .B(srcB),
        .ALUOperation(ALUcontrol),
        .ALUResult(ALUResult),
        .Zero(zero)
    );

    //Mux mux_alu_src (
    //.B(ReadData2),
    //.A(singimm),
    //.s(ALUSrc),
    //.r(srcB)
    //);

    assign srcB = ALUSrc ? singimm : ReadData2;

    DataMemory memory_unit (
        .clk(clk),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(ReadData2),
        .readData(readData)
    );
    //input wire MemRead,            // Sinal de leitura


    assign writeData = MemtoReg ? readData : ALUResult;

    //simulacao
    integer i;
    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;

        $dumpfile("mipsSc.vcd");
        $dumpvars(0, simulacao); // Dump all signals

        // Optional: Explicitly dump registers if needed
        for (integer i = 0; i < 32; i++) begin
            $dumpvars(1, simulacao.reg_unit.registers[i]);
        end

    #100;
    $finish;
end
endmodule








