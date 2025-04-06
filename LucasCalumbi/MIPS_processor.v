`include "FetchUnit.v"
`include "ControlUnit.v"
`include "Registers.v"
`include "Mux_5bits.v"
`include "Mux_32bits.v"
`include "SignalExtend.v"
`include "ALUControl.v"
`include "ALU.v"
`include "ShiftLeft2.v"
`include "ShiftLeft2_26to28bits.v"
`include "Adder32.v"
`include "DataMemory.v"

module MIPS_processor(
    input wire i_clk,
    input wire i_reset
);

    // sinais de controle
    wire w_reg_destiny_sig;
    wire w_jump_sig;
    wire w_branch_sig;
    wire w_mem_read_sig;
    wire w_mem_to_reg_sig;
    wire [1:0] w_alu_op_sig;
    wire w_mem_write_sig;
    wire w_alu_src_sig;
    wire w_reg_write_sig;
    wire w_zero_sig;
    wire w_beq_sig;
    wire w_link_sig;  
    wire w_jump_register_sig;
    wire w_mult_sig;
    wire w_is_shift_operation;
    wire w_is_RFORMAT_sig;

    // sinais de dados 
    wire [31:0] w_instruction;
    wire [31:0] w_incremented_pc;
    wire [31:0] w_read_data1;  
    wire [31:0] w_read_data2;
    wire [31:0] w_write_data;
    wire [31:0] w_extended_instruction;
    wire [31:0] w_shifted_extended_instruction;
    wire [31:0] w_mux_result1;
    wire [31:0] w_alu_result;
    wire [31:0] w_read_data;
    wire [31:0] w_new_pc_address;
    wire [31:0] w_adder32_result;
    wire [31:0] w_mux_result3;
    wire [31:0] w_mux_result4;
    wire [31:0] w_final_write_data;
    wire [27:0] w_shifted_instruction;
    wire [3:0] w_alu_operation;
    wire [31:0] w_alu_input_a;

    // enderecos
    wire [4:0] w_mux_result1_5b;
    wire [4:0] w_mux_result2_5b;
    

    FetchUnit fetchUnit(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_pc_address(w_new_pc_address),
        .o_instruction(w_instruction),
        .o_incremented_pc(w_incremented_pc)
    );


    ShiftLeft2_26to28bits shiftLeft2_26to28bits(
        .i_in(w_instruction[25:0]),
        .o_out(w_shifted_instruction)
    );

    ControlUnit controlUnit(
        .i_op_code(w_instruction[31:26]),
        .o_reg_destiny_sig(w_reg_destiny_sig),
        .o_jump_sig(w_jump_sig),
        .o_branch_sig(w_branch_sig),
        .o_mem_read_sig(w_mem_read_sig),
        .o_mem_to_reg_sig(w_mem_to_reg_sig),
        .o_alu_op_sig(w_alu_op_sig),
        .o_mem_write_sig(w_mem_write_sig),
        .o_alu_src_sig(w_alu_src_sig),
        .o_reg_write_sig(w_reg_write_sig),
        .o_link_sig(w_link_sig),
        .o_mult_sig(w_mult_sig),
        .o_is_RFORMAT_sig(w_is_RFORMAT_sig)
    );


    Mux_5bits mux5_1(
        .i_false(w_instruction[20:16]),
        .i_true(w_instruction[15:11]),
        .i_sel(w_reg_destiny_sig),
        .o_output(w_mux_result1_5b)
    );

    Mux_5bits mux5_2(
        .i_false(w_mux_result1_5b),  
        .i_true(5'b11111),          
        .i_sel(w_link_sig),          
        .o_output(w_mux_result2_5b)  
    );
    
    Mux_32bits mux32_5(
    .i_false(w_write_data),     
    .i_true(w_incremented_pc),  
    .i_sel(w_link_sig),
    .o_output(w_final_write_data) 
    );

    Registers registers(
        .i_clk(i_clk),
        .i_read_register1(w_instruction[25:21]),  
        .i_read_register2(w_instruction[20:16]),  
        .i_write_register(w_mux_result2_5b),  
        .i_write_data(w_final_write_data),     
        .i_reg_write_sig(w_reg_write_sig),             
        .o_read_data1(w_read_data1),    
        .o_read_data2(w_read_data2)     
    );


    ALUControl aluControl(
        .i_alu_operation_sig(w_alu_op_sig),
        .i_fun_code(w_instruction[5:0]),
        .i_mult_sig(w_mult_sig),
        .i_is_RFORMAT_sig(w_is_RFORMAT_sig),
        .o_alu_operation(w_alu_operation),
        .o_jump_register_sig(w_jump_register_sig),
        .o_is_shift_operation(w_is_shift_operation)
    );


    SignalExtend signalExtend(
        .i_in(w_instruction[15:0]),
        .o_out(w_extended_instruction)
    );

    ShiftLeft2 shiftLeft2_2(
        .i_in(w_extended_instruction),
        .o_out(w_shifted_extended_instruction)
    );

    Mux_32bits mux32_1(
        .i_false(w_read_data2),
        .i_true(w_extended_instruction),
        .i_sel(w_alu_src_sig),
        .o_output(w_mux_result1)
    );
    
    
    Mux_32bits mux_shamt(
        .i_false(w_read_data1),     
        .i_true({27'b0, w_instruction[10:6]}),  // extensão do shamt
        .i_sel(w_is_shift_operation),  
        .o_output(w_alu_input_a)  
    );

    ALU alu(
        .i_op_a(w_alu_input_a),
        .i_op_b(w_mux_result1),
        .i_alu_operation(w_alu_operation),
        .o_alu_result(w_alu_result),
        .o_zero_sig(w_zero_sig)
    );

    DataMemory dataMemory(
        .i_clk(i_clk),
        .i_mem_read_sig(w_mem_read_sig),
        .i_mem_write_sig(w_mem_write_sig),
        .i_address(w_alu_result),
        .i_write_data(w_read_data2),
        .o_read_data(w_read_data)
    );

    Mux_32bits mux32_2(
        .i_false(w_alu_result),
        .i_true(w_read_data),
        .i_sel(w_mem_to_reg_sig),
        .o_output(w_write_data)
    );

    and and0(w_beq_sig,w_branch_sig,w_zero_sig);

    Adder32 adder32(
        .i_op_a(w_incremented_pc),
        .i_op_b(w_shifted_extended_instruction),
        .o_result(w_adder32_result)
    );

    
    // para o jr
    Mux_32bits mux32_6(
        .i_false(w_incremented_pc),
        .i_true(w_read_data1),   
        .i_sel(w_jump_register_sig),
        .o_output(w_mux_result4)
    );


    Mux_32bits mux32_3(
        .i_false(w_mux_result4),
        .i_true(w_adder32_result),
        .i_sel(w_beq_sig),
        .o_output(w_mux_result3)
    );


    Mux_32bits mux32_4(
        .i_false(w_mux_result3),
        .i_true({w_incremented_pc[31:28],w_shifted_instruction}),
        .i_sel(w_jump_sig),
        .o_output(w_new_pc_address)
    );



endmodule