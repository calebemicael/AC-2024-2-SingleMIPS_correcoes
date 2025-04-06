
module Processador (
  input clk,          
  input reset            
);

  // Sinais internos
  wire [31:0] pc_incrementado, pc_desvio, pc_jump;
  wire [31:0] instruction;
  wire [31:0] alu_result, read_data_mem, write_data;
  wire [31:0] read_data1, read_data2, sign_extended, alu_src_b;
  wire [31:0] endereco_deslocado;
  wire [4:0] write_register;
  wire [3:0] alu_control;

  // Sinais de controle
  wire reg_dst, branch, mem_read, mem_to_reg;
  wire mem_write, alu_src, reg_write, zero;
  wire [1:0] alu_op;


  reg [31:0] pc;
  always @(posedge clk or posedge reset) begin
      if (reset)
          pc <= 32'b0;
      else
          pc <= pc_incrementado;
  end
  // Add4
  Add4 add4 (
    .in(pc),
    .out(pc_incrementado)
  );

  // Instruction Memory
  MemoriaDeInstrucoes MI (
    .addr(pc),
    .instrucao(instruction)
  );

  // Control Unit
  Control Control (
    .opcode(instruction[31:26]),
    .RegDst(reg_dst),
    .Branch(branch),
    .MemRead(mem_read),
    .MemtoReg(mem_to_reg),
    .ALUOp(alu_op),
    .MemWrite(mem_write),
    .ALUSrc(alu_src),
    .RegWrite(reg_write),
    .Jump(jump)
  );

  // Register File
  Registradores RF (
    .clk(clk),
    .ReadRegister1(instruction[25:21]),
    .ReadRegister2(instruction[20:16]),
    .WriteRegister(write_register),
    .WriteData(write_data),
    .RegWrite(reg_write),
    .ReadData1(read_data1),
    .ReadData2(read_data2)
  );

  // MUX para Write Register
  Mux5 mux_reg_dst (
    .entrada0(instruction[20:16]),
    .entrada1(instruction[15:11]),
    .sel(reg_dst),
    .saida(write_register)
  );

  // Sign-extend
  SignExtend SE (
    .in(instruction[15:0]),
    .out(sign_extended)
  );

  // MUX para ALU Source
  Mux32 mux_alu_src (
    .entrada0(read_data2),
    .entrada1(sign_extended),
    .sel(alu_src),
    .saida(alu_src_b)
  );

  // ALU Control
  ALUControl alu_ctrl (
    .ALUOp(alu_op),
    .funct(instruction[5:0]),
    .ALUControl(alu_control)
  );

  // ALU
  ALU alu (
    .A(read_data1),
    .B(alu_src_b),
    .ALUOperation(alu_control),
    .ALUResult(alu_result),
    .Zero(zero)
  );

  // Data Memory
  DataMemory DM (
    .clk(clk),
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .address(alu_result),
    .writeData(read_data2),
    .readData(read_data_mem)
  );

  // MUX para Write Data
  Mux32 mux_mem_to_reg (
    .sel(mem_to_reg),
    .entrada0(alu_result),
    .entrada1(read_data_mem),
    .saida(write_data)
  );

  ShiftLeft2 desloca_esquerda_2(
        .in(sign_extended),
        .out(endereco_deslocado)
    );

  Adder32 somador_desvio(
      .a(pc_incrementado),
      .b(endereco_deslocado),
      .sum(pc_desvio)
  );

     // Cálculo do endereço do jump
  assign pc_jump = {pc_incrementado[31-28], instruction[25:0], 2'b00};

  // Mux para escolher o próx PC
  wire [31:0] prox_pc;
  assign prox_pc = (jump) ? pc_jump :   // jump
                   (branch & zero) ? pc_desvio :
                   pc_incrementado;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      pc <= 32'b0;
    else
      pc <= prox_pc;
  end
  
endmodule
