
module ControlUnit(
    input wire [5:0] i_op_code,
    output wire o_reg_destiny_sig, 
    output wire o_jump_sig,
    output wire o_branch_sig,
    output wire o_mem_read_sig,
    output wire o_mem_to_reg_sig,
    output wire [1:0] o_alu_op_sig,
    output wire o_mem_write_sig,
    output wire o_alu_src_sig,
    output wire o_reg_write_sig,
    output wire o_link_sig,
    output wire o_mult_sig,
    output wire o_is_RFORMAT_sig
);
    
    localparam R_FORMAT = 6'b000000;
    localparam LW       = 6'b100011;
    localparam SW       = 6'b101011;
    localparam BEQ      = 6'b000100;
    localparam JUMP     = 6'b000010;
    localparam ADDI     = 6'b001000;
    localparam ADDIU    = 6'b001001;
    localparam JAL      = 6'b000011;
    localparam ANDI     = 6'b001100;
    localparam SPECIAL  = 6'b011100; // armengo
    
   
    // nao tá bonito, mas tá funcional
    assign o_reg_destiny_sig = (i_op_code == R_FORMAT) || (i_op_code == SPECIAL);

    assign o_is_RFORMAT_sig = (i_op_code == R_FORMAT);
    
    assign o_jump_sig = (i_op_code == JUMP) || (i_op_code == JAL);

    assign o_branch_sig = (i_op_code == BEQ);

    assign o_mem_read_sig = (i_op_code == LW);

    assign o_mem_to_reg_sig = (i_op_code == LW);

    assign o_mem_write_sig = (i_op_code == SW);

    assign o_alu_src_sig = (i_op_code == LW) || (i_op_code == SW) || (i_op_code == ADDI) 
                                || (i_op_code == ADDIU) || (i_op_code == ANDI);

    assign o_reg_write_sig = (i_op_code == R_FORMAT) || (i_op_code == LW) || (i_op_code == ADDI) 
                                || (i_op_code == JAL) || (i_op_code == ADDIU) || (i_op_code == ANDI)
                                || (i_op_code == SPECIAL);
    
    assign o_link_sig = (i_op_code == JAL);
    
    assign o_mult_sig = (i_op_code == SPECIAL);
    
    assign o_alu_op_sig = (i_op_code == R_FORMAT || i_op_code == SPECIAL) ? 2'b10 :
                          (i_op_code == BEQ) ? 2'b01 :
                          (i_op_code == ANDI) ? 2'b11 :
                          2'b00;
    

endmodule


