module mips(
    input wire clk,
    input wire reset,
    output wire [31:0] pc_out,
    output wire [31:0] instrucao_out
);
    wire RegWrite, ALUSrc, MemtoReg, Branch, MemRead, MemWrite, Jump, RegDst;
    wire [1:0] ALUOp;

    wire [31:0] instrucao; // Instrução atual
    wire [31:0] pc_plus4 = pc_out + 4; // PC + 4 (próxima instrução)
    wire [31:0] jump_address = {pc_plus4[31:28], instrucao[25:0], 2'b00}; // Endereço de jump

    wire [31:0] sign_extended_immediate;
    SignalExtend sign_extend (
        .in(instrucao[15:0]),
        .out(sign_extended_immediate)
    );

    wire [31:0] jump_shifted;
    ShiftLeft2 jump_shift (
        .in({6'b0, instrucao[25:0]}), 
        .out(jump_shifted)
    );

    FetchUnit fetch (
        .clk(clk),
        .reset(reset),
        .Jump(Jump),
        .jump_address(jump_address),
        .instrucao(instrucao)
    );

    assign pc_out = fetch.pc;
    assign instrucao_out = instrucao;

    control_unit control (
        .opcode(instrucao[31:26]), // opcode da instrucao
        .RegWrite(RegWrite),      //  escrita no banco de registradores
        .ALUSrc(ALUSrc),          //  selecao do segundo operando da ULA
        .MemtoReg(MemtoReg),      //  selecao do dado a ser escrito no registrador
        .Branch(Branch),          //  branch
        .MemRead(MemRead),        //  leitura da memoria
        .MemWrite(MemWrite),      //  escrita na memoria
        .ALUOp(ALUOp),            //  controle da ULA
        .Jump(Jump),              //  jump
        .RegDst(RegDst)           //  selecao do registrador de destino
    );

    wire [4:0] reg_write_addr = (RegDst) ? instrucao[15:11] : instrucao[20:16];

    wire [31:0] readData1, readData2, writeData;
    registradores regs (
        .clk(clk),
        .v1_loc(instrucao[25:21]), 
        .v2_loc(instrucao[20:16]),
        .v_write_res(writeData),
        .r_write_res(reg_write_addr), 
        .signal(RegWrite),
        .get_reg1(readData1),
        .get_reg2(readData2)
    );

    wire [3:0] ALUControl;

    ALUControl alu_control (
        .ALUOp(ALUOp),            // controle da ULA (da unidade de controle)
        .funct(instrucao[5:0]),   // funct da instrução r
        .ALUControl(ALUControl)   // controle da ULA
    );

    wire [31:0] ALUResult;
    ula ula_inst (
        .f(ALUControl), 
        .A(readData1),
        .B(ALUSrc ? sign_extended_immediate : readData2),
        .RES(ALUResult)
    );

    wire [31:0] memReadData;
    DataMemory data_mem (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(readData2),
        .readData(memReadData)
    );

    wire [31:0]  pc_next_jump, pc_next;
    Add4 add4 (.in(fetch.pc), .out(pc_plus4));

    mux2x1 mux_jump (
        .in0(pc_plus4),
        .in1(jump_address),
        .sel(Jump),
        .out(pc_next_jump)
    );

    
    mux2x1 mux_branch (
        .in0(pc_next_jump),
        .in1(pc_plus4 + (sign_extended_immediate << 2)),
        .sel(Branch & Zero), 
        .out(pc_next)
    );

    mux2x1 mux_memtoreg (
        .in0(ALUResult),
        .in1(memReadData),
        .sel(MemtoReg),
        .out(writeData)
    );
endmodule
