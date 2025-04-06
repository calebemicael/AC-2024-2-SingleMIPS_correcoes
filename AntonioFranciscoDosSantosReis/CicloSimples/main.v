`include "ALU_control.v"
`include "ALU_unit.v"
`include "auxiliar.v"
`include "control_unit.v"
`include "data_memory.v"
`include "file_registers.v"
`include "instruction_memory.v"
`include "pc_counter.v"
`include "signal_extend.v"

module top(clk, reset);
    input clk, reset;

    wire [31:0] PC_top, PCin_top, instruction_top, Rd1_top, Rd2_top, bits_extends_top, ALU_mux_top, pc_outplus_top, out_adder_top, ALU_result_top, read_data_top, writeBackData_top, mergebitsJump_top, mux_adder_out_top;
    wire [4:0] writeRegister_top;
    wire regWrite_top, ALUSrc_top, branch_top, memRead_top, memWrite_top, RegDst_top, memtoReg_top;
    wire [1:0] ALUop_top;
    wire [2:0] alu_control_top;
    wire zero_top, and_out_top;
    wire in2;
    wire jump_top;
    

    wire [31:0] data_in_top;
    wire [6:0] seg_top;
    wire [3:0] an_top;


    //Program Counter
    pc_counter PC (.clk(clk), .reset(reset), .pc_in(PCin_top), .pc_out(PC_top));

    //PC ADDER
    pc_plus4 PC_ADDER (.pc_out(PC_top), .pc_outplus(pc_outplus_top));

    // Instruction Memory
    instruction_memory Inst_Memory(.clk(clk), .reset(reset), .read_address(PC_top), .instruction_out(instruction_top));

    //muxSelect_Register
    muxSelect_Register m1(.A(instruction_top[20:16]), .B(instruction_top[15:11]), .sel1(RegDst_top), .out(writeRegister_top));

    //Register File
    file_registers Reg_File(.clk(clk), .reset(reset), .regWrite(regWrite_top), .Rs1(instruction_top[25:21]), .Rs2(instruction_top[20:16]), .wR(writeRegister_top), .writeData(writeBackData_top), .Rd1(Rd1_top), .Rd2(Rd2_top));
    
    //Sign Extend
    signal_extend Sig_Ext(.instruction(instruction_top[15:0]), .bits_extends(bits_extends_top));

    //Control Unit
    control_unit Control_unit(.instruction(instruction_top[31:26]), .RegDst(RegDst_top), .Branch(branch_top), .MemRead(memRead_top), .MemtoReg(memtoReg_top), .ALUop(ALUop_top), .MemWrite(memWrite_top), .ALUSrc(ALUSrc_top), .RegWrite(regWrite_top), .jump(jump_top));

    //ALU_CONTROL
    ALU_control ALU_C(.ALUop(ALUop_top), .funct(instruction_top[5:0]), .ALUControl(alu_control_top));

    //ALU
    ALU_unit ALU(.A(Rd1_top), .B(ALU_mux_top), .alu_control(alu_control_top), .ALU_result(ALU_result_top), .zero(zero_top));

    //ALU_MUX
    mux1 ALU_mux(.A(Rd2_top), .B(bits_extends_top), .sel1(ALUSrc_top), .out(ALU_mux_top));

    //adder
    //assign in2 = bits_extends_top << 2;
    adder add (.in1(pc_outplus_top), .in2(bits_extends_top), .out_adder(out_adder_top));

    

    //and gate
    and_logic and_gate(.branch(branch_top), .zero(zero_top), .and_out(and_out_top));

    //mux out PCin_top
    mux2 Adder_mux(.A2(pc_outplus_top), .B2(out_adder_top), .sel2(and_out_top), .out2(mux_adder_out_top));


    //Data memory
    data_Memory data_mem(.address(ALU_result_top), .write_Data(Rd2_top), .memRead(memRead_top), .memWrite(memWrite_top), .clk(clk), .reset(reset), .read_Data(read_data_top));

    //mux data memory
    mux2 data_memory_mux(.A2(ALU_result_top), .B2(read_data_top), .sel2(memtoReg_top), .out2(writeBackData_top));

    concatBits u1(.in1(instruction_top[25:0]), .in2(pc_outplus_top[31:28]), .out1(mergebitsJump_top));

    muxJump mjump(.A(mux_adder_out_top), .B(mergebitsJump_top), .sel(jump_top), .out(PCin_top));

  
endmodule
