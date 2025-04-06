module MIPS(
    input wire clk,
    input wire reset
);

wire[31:0] instrucao;
wire[31:0] pc_incrementado_output;
wire[31:0] write_data;
wire[31:0] read_data_1;
wire[31:0] read_data_2;
wire[31:0] sign_extended;
wire[31:0] aluSrc_result;
wire[31:0] alu_result_adress;
wire[31:0] read_data; // data memory
wire[31:0] shift_left_result;
wire[31:0] alu_sum_result;
wire[31:0] branch_result;
wire[31:0] jump_adress;
wire[31:0] jump_result;
wire[27:0] shift_left_jump_result;
wire[4:0] write_register;
wire[3:0] alu_operation;
wire[1:0] alu_op;
wire zero;
wire branch_and_zero_result;
wire reg_dst;
wire mem_read;
wire memto_reg;
wire mem_write;
wire alu_Src;
wire reg_write;
wire jump;

Control control(
    .OPcode(instrucao[31:26]),
    .zero(zero),
    .RegDst(reg_dst),
    .Branch_and_zero_result(branch_and_zero_result),
    .MemRead(mem_read),
    .MemtoReg(memto_reg),
    .MemWrite(mem_write),
    .ALUSrc(alu_Src),
    .RegWrite(reg_write),
    .ALUOp(alu_op),
    .Jump(jump)
);

FetchUnit fetch_unit(
    .clk(clk),
    .reset(reset),
    .PcIncrementadoOutput(pc_incrementado_output),
    .BranchResult(jump_result), // jum_result vem do processamento do mux do branch_result seguido do mux do jump_result
    .instrucao(instrucao)
);

MUX_5bits mux_regDst(
    .in_1(instrucao[20:16]),
    .in_2(instrucao[15:11]),
    .RegDst(reg_dst), 
    .out(write_register)
);

Registradores registradores(
    .clk(clk),
    .ReadRegister1(instrucao[25:21]),
    .ReadRegister2(instrucao[20:16]),
    .WriteRegister(write_register), 
    .WriteData(write_data), 
    .RegWrite(reg_write), 
    .ReadData1(read_data_1),
    .ReadData2(read_data_2)
);

SignalExtend extensor_bits(
    .in(instrucao[15:0]),
    .out(sign_extended)
);

MUX_32bits_ALUSrc mux_aluSrc(
    .ReadData2(read_data_2),
    .SignExtend(sign_extended),
    .ALUSrc(alu_Src), 
    .out(aluSrc_result)
);

ALU_Control alu_control(
    .instruction(instrucao[5:0]),
    .ALUOp(alu_op), 
    .ALUOperation(alu_operation)
);

ALU alu(
    .A(read_data_1),
    .B(aluSrc_result),
    .ALUOperation(alu_operation),
    .ALUResult(alu_result_adress),
    .Zero(zero)
);

DataMemory data_memory(
    .Clk(clk),
    .MemRead(mem_read), 
    .MemWrite(mem_write), 
    .address(alu_result_adress),
    .writeData(read_data_2),
    .readData(read_data)
);

MUX_32bits_MemtoReg mux_memtoReg(
    .ReadData(read_data),
    .AluResult(alu_result_adress),
    .MemtoReg(memto_reg), 
    .out(write_data)
);

ShiftLeft2 shift_left(
    .in(sign_extended),
    .out(shift_left_result)
);

Adder32 adder_32(
    .a(pc_incrementado_output), 
    .b(shift_left_result),
    .sum(alu_sum_result)
);

MUX_32bits_BEQ mux_beq(
    .AddResult(pc_incrementado_output), 
    .AluResult(alu_sum_result),
    .seletor(branch_and_zero_result), 
    .out(branch_result) 
);

ShiftLeft2_jump shift_left_jump(
    .in(instrucao[25:0]),
    .out(shift_left_jump_result) //declarar
);

Concat concat(
    .A(shift_left_jump_result),
    .B(pc_incrementado_output[31:28]),
    .out(jump_adress)
);

MUX_32bits_jump mux_jump(
    .JumpAdress(jump_adress),
    .muxAnterior(branch_result),
    .Jump(jump),
    .out(jump_result)
);

endmodule