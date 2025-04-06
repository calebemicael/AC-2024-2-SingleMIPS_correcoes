module ProcessadorMIPS(
    input wire clk,
    input wire rst
);

    reg [31:0] pc;

    wire [31:0] pc_incrementado;

    Add4 add4(
        .in(pc),
        .out(pc_incrementado)
    );

    wire [31:0] instruction; 

    MemoriaDeInstrucoes memoria(
        .addr(pc),
        .instrucao(instruction)
    );

    wire reg_dst, jump, ALU_src, memto_reg, reg_write, mem_read, mem_write, branch;
    wire [1:0] ALU_op; 

    Control control_unit(
        .Op(instruction[31:26]),
        .RegDst(reg_dst),
        .Jump(jump),
        .ALUSrc(ALU_src),
        .MemtoReg(memto_reg),
        .RegWrite(reg_write),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .Branch(branch),
        .ALUOp(ALU_op)
    );

    wire [31:0] jump_address;

    JumpAddressCalculator jac(
        .instruction(instruction[25:0]),
        .PCPlus4(pc_incrementado[31:28]),
        .JumpAddress(jump_address)
    );

    wire [4:0] mux_reg_result;

    MUX_5b_2x1 mux_reg(
        .A(instruction[20:16]),
        .B(instruction[15:11]),
        .sel(reg_dst),
        .MUX_5b_Result(mux_reg_result)
    );

    wire [31:0] read_data1, read_data2, write_data;

    Registradores registradores(
        .clk(clk),
        .ReadRegister1(instruction[25:21]),
        .ReadRegister2(instruction[20:16]),
        .WriteRegister(mux_reg_result),
        .WriteData(write_data),
        .RegWrite(reg_write),
        .ReadData1(read_data1),
        .ReadData2(read_data2)
    );

    wire [31:0] out_sign_extend;

    SignExtend sign_extend(
        .in(instruction[15:0]),
        .out(out_sign_extend)
    );

    wire [31:0] mux_ALU_result;

    MUX_32b_2x1 mux_ALU(
        .A(read_data2),
        .B(out_sign_extend),
        .sel(ALU_src),
        .MUX_32b_Result(mux_ALU_result)
    );

    wire [31:0] shift_left_out;

    ShiftLeft2 shift_left(
        .in(out_sign_extend),
        .out(shift_left_out)
    );

    wire [3:0] ALU_control_input;

    ALUControl ALU_control(
        .FunctField(instruction[5:0]),
        .ALUOp(ALU_op),
        .ALUControl_Input(ALU_control_input)
    );

    wire [31:0] ALU_result;
    wire zero;

    ALU alu(
        .A(read_data1),
        .B(mux_ALU_result),
        .ALUOperation(ALU_control_input),
        .ALUResult(ALU_result),
        .Zero(zero)
    );

    wire [31:0] adder32_result;

    Adder32 adder32(
        .a(pc_incrementado),
        .b(shift_left_out),
        .sum(adder32_result)
    );

    wire and_result;

    and(and_result, branch, zero);

    wire [31:0] mux_and_result;

    MUX_32b_2x1 mux_and(
        .A(pc_incrementado),
        .B(adder32_result),
        .sel(and_result),
        .MUX_32b_Result(mux_and_result)
    );

    wire [31:0] read_data;

    DataMemory data_memory(
        .clk(clk),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .address(ALU_result),
        .writeData(read_data2),
        .readData(read_data)
    );

    MUX_32b_2x1 mux_data(
        .A(ALU_result),
        .B(read_data),
        .sel(memto_reg),
        .MUX_32b_Result(write_data)
    );

    wire [31:0] mux_jump_result;

    MUX_32b_2x1 mux_jump(
        .A(mux_and_result),
        .B(jump_address),
        .sel(jump),
        .MUX_32b_Result(mux_jump_result)
    );

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            pc <= 32'b0;
        end else begin
            pc <= mux_jump_result;
        end
    end

endmodule