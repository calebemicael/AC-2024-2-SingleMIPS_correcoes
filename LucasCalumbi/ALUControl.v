
module ALUControl(
    input wire [1:0] i_alu_operation_sig,
    input wire [5:0] i_fun_code,
    input wire i_mult_sig,
    input wire i_is_RFORMAT_sig,
    output reg [3:0] o_alu_operation,
    output wire o_jump_register_sig,
    output wire o_is_shift_operation
);

    localparam FUNCT_ADD  = 6'b100000; 
    localparam FUNCT_SUB  = 6'b100010; 
    localparam FUNCT_AND  = 6'b100100; 
    localparam FUNCT_OR   = 6'b100101; 
    localparam FUNCT_SLT  = 6'b101010; 
    localparam FUNCT_JR   = 6'b001000;
    localparam FUNCT_SRL  = 6'b000010;

    
    localparam ALU_ADD  = 4'b0010;
    localparam ALU_SUB  = 4'b0110;
    localparam ALU_AND  = 4'b0000;
    localparam ALU_OR   = 4'b0001; 
    localparam ALU_SLT  = 4'b0111;
    localparam ALU_NOP  = 4'b1111; // no operation
    localparam ALU_SRL  = 4'b1001;
    localparam ALU_MUL  = 4'b1010; // armengo

    always @(*) begin
        case (i_alu_operation_sig)
            2'b00 : o_alu_operation = ALU_ADD;  // LW, SW (tipo I)
            2'b01 : o_alu_operation = ALU_SUB;  // BEQ (tipo I)
            2'b10 : 
                if(i_mult_sig) begin
                        o_alu_operation = ALU_MUL;
                end
                else begin
                    case (i_fun_code)  // tipo R
                        FUNCT_ADD: o_alu_operation = ALU_ADD;
                        FUNCT_SUB: o_alu_operation = ALU_SUB;
                        FUNCT_AND: o_alu_operation = ALU_AND;
                        FUNCT_OR:  o_alu_operation = ALU_OR;
                        FUNCT_SLT: o_alu_operation = ALU_SLT;
                        FUNCT_SRL: o_alu_operation = ALU_SRL;
                        default:   o_alu_operation = ALU_NOP;
                    endcase
                end
            2'b11 : o_alu_operation = ALU_AND;
            default: o_alu_operation = ALU_NOP;
        endcase
    end
                                        // tipo R                     // fun code  == 8
    assign o_jump_register_sig = (i_alu_operation_sig == 2'b10) && (i_fun_code == FUNCT_JR);
    assign o_is_shift_operation = (i_is_RFORMAT_sig && (i_fun_code == FUNCT_SRL)); // armengo
endmodule
