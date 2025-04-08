module mips_single_cycle( // entregou com erros de sintaxe ~ nao rodou antes de entregar?
    input clk, reset,
    input [31:0] instruction,
    output [31:0] pc,
    output reg_write, alu_src, branch, jump,
    output [31:0] alu_input_2
);
    wire [31:0] pc_prox;
    wire [31:0] read_data_1, read_data_2, write_data, alu_result, sign_extend, mem_read_data;
    wire zero, reg_dst, mem_to_reg, mem_read, mem_write;
    wire [2:0] alu_ctrl, alu_op;
    wire pc_src;

    // Program Counter
  pc pc_inst ( // as entradas e saídas estão corretas?
        .pc_prox(pc_prox),
        .clk(clk),
        .reset(reset),
        //.pc_src(pc_src),
        .pc(pc)
);
    assign pc_prox = (jump) ? {pc[31:28], instruction[25:0], 2'b00} :
                     (branch & zero) ? (pc + 4 + (sign_extend << 2)) : (pc + 4);

    // Memória de Instruções
    instruction_memory IM ( // as entradas e saídas estão corretas?
        //.clk(clk),
        .addr(pc),
        .instruction(instruction)
);

    // Unidade de Controle
    control_unit cu_inst ( // as entradas e saídas estão corretas?
        .opcode(instruction[31:26]),
        .funct(instruction[5:0]),
        .reg_dst(reg_dst),
        .jump(jump),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write)
    );

    // Banco de Registradores
    register_file rf_inst ( // as entradas e saídas estão corretas?
        .clk(clk),
        // .reset(reset),
        .read_reg_1(instruction[25:21]),
        .read_reg_2(instruction[20:16]),
        .write_reg(instruction[15:11]),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    // ALU
    alu alu_inst ( // as entradas e saídas estão corretas?
        // .clk(clk),
        .op(alu_op),
        .input_1(read_data_1),
        .input_2(alu_input_2),
        .result(alu_result),
        .zero(zero)
    );

    // Unidade de Controle da ALU
    alu_control_unit alu_ctrl_inst (
        .alu_ctrl(alu_ctrl),
        .funct(instruction[5:0]),
        .alu_op(alu_op)
    );

    // Extensão de Sinal
    sign_extension se_inst ( // as entradas e saídas estão corretas?
        .immediate(instruction[15:0]),
        .extended(sign_extend)
    );

    // Memória de Dados
    data_memory dm_inst (
        .clk(clk),
        .addr(alu_result),
        .write_data(write_data),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_read_data(mem_read_data)
    );

    //Muxs
    mux2to1 mux_pc (
        .sel(pc_src),
        .ent0(pc + 4),
        .ent1(alu_result),
        .out(pc_prox)
    );

    mux2to1 mux_alu_input_2 (
        .sel(alu_src),
        .ent0(read_data_2),
        .ent1(sign_extend),
        .out(alu_input_2)
    );

    mux2to1 mux_write_data (
        .sel(mem_to_reg),
        .ent0(alu_result),
        .ent1(mem_read_data),
        .out(write_data)
    );
    mux2to1 mux_pc_src (
        .sel(jump),
        .ent0(pc + 4),
        .ent1(pc + 4 + (sign_extend << 2)),
        .out(pc_prox)
    );

    assign pc = pc_prox;

    assign write_data = (mem_to_reg) ? mem_read_data : alu_result;
    
endmodule