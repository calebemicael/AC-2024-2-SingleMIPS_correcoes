`include "FetchUnit.v"
`include "MemoriaDeInstrucoes.v"
`include "controle.v"
`include "Registradores.v"
`include "multiRegDst.v"
`include "multiPCSrc.v"
`include "multiMemtoReg.v"
`include "multiALUSrc.v"
`include "DataMemory.v"
`include "SignExtend.v"
`include "controleULA.v"
`include "ALU.v"    
`include "Add4.v"

module processador(
    input wire clk, reset,
    output wire [31:0] pc,       
    output wire [31:0] instrucao, 
    output wire [31:0] ALUResult, 
    output wire Zero             
);

    wire RegDst, MemRead, Branch, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    wire [31:0] sinalImediato, readdata1, readdata2, readData, writeData;
    wire [31:0] proxPC, pc_add4, branch_add, jump_addr;
    wire [4:0] RegDst_out;
    wire [31:0] entrada2ALU;

    reg [31:0] pc_reg;

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_reg <= 0;
        else
            pc_reg <= proxPC;
    end

    assign pc = pc_reg;


    FetchUnit fetchUnit (
        .clk(clk),
        .reset(reset),
        .instrucao(instrucao)
    );

    controle UnidadeDeControle(
        .opcode(instrucao[31:26]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    Registradores registradores(
        .clk(clk),
        .reset(reset),
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(RegDst_out),
        .WriteData(writeData),
        .RegWrite(RegWrite),
        .ReadData1(readdata1),
        .ReadData2(readdata2)
    );

    multiRegDst muxRegdst(
        .rt(instrucao[20:16]),
        .rd(instrucao[15:11]),
        .RegDst(RegDst),
        .RegDst_out(RegDst_out)
    );

    SignExtend sinal(
        .in(instrucao[15:0]),
        .out(sinalImediato)
    );

    controleULA controlALU(
        .opALU(ALUOp),
        .funct(instrucao[5:0]),
        .ALUcontrol(ALUControl)
    );

    multiALUSrc muxALUSrc(
        .rt(readdata2),
        .sinalImediato(sinalImediato),
        .ALUSrc(ALUSrc),
        .entrada2ALU(entrada2ALU)
    );

    ALU alu(
        .A(readdata1),
        .B(entrada2ALU),
        .ALUOperation(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    DataMemory MemoriaDeDados(
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(readdata2),
        .readData(readData)
    );

    multiMemtoReg muxMemtoReg(
        .ALU_result(ALUResult),
        .readData(readData),
        .memtoReg(MemtoReg),
        .writeData(writeData)
    );

    assign branch_add = (sinalImediato << 2) + pc_add4;
    assign pc_add4 = pc + 4;
    assign jump_addr = {pc_add4[31:28], instrucao[25:0], 2'b00};

    multiPCSrc muxPCSrc(
        .pc_add4(pc_add4),
        .branch_add(branch_add),
        .jump_addr(jump_addr),
        .Branch(Branch),
        .Jump(Jump), 
        .proxPC(proxPC)
    );

endmodule