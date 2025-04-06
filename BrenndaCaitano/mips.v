module mips (
    input clk,
    input reset
);
    // Conexões internas
    wire [31:0] pc_current, pc_next, pc_plus4, pc_branch, pc_jump, jump_address;
    wire [31:0] instr;
    wire [31:0] reg_data1, reg_data2, alu_result, mem_read_data, sign_ext_imm;
    wire [31:0] alu_src_b, write_back_data;
    wire [4:0] write_reg;
    wire [2:0] alu_control_signal;
    wire zero_flag, branch, mem_read, mem_write, reg_write, jump, alu_src, reg_dst, mem_to_reg;
    wire [1:0] alu_op;
    wire pc_src;

    // ---------- Instanciação dos Componentes ----------

    // PC (Program Counter)
    pc program_counter (
        .clk(clk),
        .reset(reset),
        .next_pc(pc_next),
        .current_pc(pc_current)
    );

    // Memória de Instruções
    imem instruction_memory (
        .addr(pc_current),
        .instr(instr)
    );

    // Unidade de Controle Principal
    control control_unit (
        .opcode(instr[31:26]),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op),
        .jump(jump)
    );

    // Banco de Registradores
    regfile register_file (
        .clk(clk),
        .read_reg1(instr[25:21]),
        .read_reg2(instr[20:16]),
        .write_reg(write_reg),
        .write_data(write_back_data),
        .reg_write(reg_write),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // Extensão de Sinal
    sign_extend sign_extension (
        .imm(instr[15:0]),
        .ext_imm(sign_ext_imm)
    );

    // Mux ALUSrc
    mux_2to1 #(32) alu_src_mux (
        .in0(reg_data2),
        .in1(sign_ext_imm),
        .sel(alu_src),
        .out(alu_src_b)
    );

    // Controle da ALU
    alu_control alu_ctrl (
        .alu_op(alu_op),
        .funct(instr[5:0]),
        .alu_control_signal(alu_control_signal)
    );

    // ALU
    ALU arithmetic_logic_unit (
        .a(reg_data1),
        .b(alu_src_b),
        .alu_control(alu_control_signal),
        .result(alu_result),
        .zero(zero_flag)
    );

    // Memória de Dados
    dMem data_memory (
        .clk(clk),
        .addr(alu_result),
        .write_data(reg_data2),
        .mem_write(mem_write),
        .read_data(mem_read_data)
    );

    // Mux MemtoReg
    mux_2to1 #(32) mem_to_reg_mux (
        .in0(alu_result),
        .in1(mem_read_data),
        .sel(mem_to_reg),
        .out(write_back_data)
    );

    // Mux RegDst
    mux_2to1 #(5) reg_dst_mux (
        .in0(instr[20:16]),
        .in1(instr[15:11]),
        .sel(reg_dst),
        .out(write_reg)
    );

    // Cálculo do Desvio (Branch)
    adder pc_plus4_adder (
        .a(pc_current),
        .b(32'h4),
        .out(pc_plus4)
    );

    adder branch_adder (
        .a(pc_plus4),
        .b({sign_ext_imm[29:0], 2'b00}),
        .out(pc_branch)
    );

    // Lógica de Branch
    assign pc_src = branch & zero_flag;

    // Mux PCSrc
    mux_2to1 #(32) branch_mux (
        .in0(pc_plus4),
        .in1(pc_branch),
        .sel(pc_src),
        .out(pc_jump)
    );

    // Lógica de Jump
    shift_left_jump jump_shift (
        .address(instr[25:0]),
        .pc_plus_4(pc_plus4),
        .jump_address(jump_address)
    );

    // Mux Jump
    mux_2to1 #(32) jump_mux (
        .in0(pc_jump),
        .in1(jump_address),
        .sel(jump),
        .out(pc_next)
    );

endmodule