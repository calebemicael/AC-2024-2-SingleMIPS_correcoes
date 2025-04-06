module ALU(
    input wire [31:0] i_op_a,           // Operando 1
    input wire [31:0] i_op_b,           // Operando 2
    input wire [3:0] i_alu_operation, // Código da operação ALU
    output reg [31:0] o_alu_result,   // Resultado da ALU
    output wire o_zero_sig               // Sinal Zero (ativo quando ALUResult é 0)
);

    localparam ALU_ADD  = 4'b0010;
    localparam ALU_SUB  = 4'b0110;
    localparam ALU_AND  = 4'b0000;
    localparam ALU_OR   = 4'b0001; 
    localparam ALU_SLT  = 4'b0111;
    localparam ALU_NOR  = 4'b1100;
    localparam ALU_NOP  = 4'b1111; // no operation
    localparam ALU_SRL  = 4'b1001;
    localparam ALU_MUL  = 4'b1010; // armengo

    always @(*) begin
        case (i_alu_operation)
            ALU_AND: o_alu_result = i_op_a & i_op_b;         
            ALU_OR: o_alu_result = i_op_a | i_op_b;         
            ALU_ADD: o_alu_result = i_op_a + i_op_b;          
            ALU_SUB: o_alu_result = i_op_a - i_op_b;          
            ALU_SLT: o_alu_result = (i_op_a < i_op_b) ? 1 : 0; 
            ALU_NOR: o_alu_result = ~(i_op_a | i_op_b);      
            ALU_SRL: o_alu_result = i_op_b >> i_op_a[4:0];           
            ALU_MUL: o_alu_result = i_op_a * i_op_b; // armengo
            default: o_alu_result = 32'b0;         
        endcase
    end

    // Define o sinal Zero
    assign o_zero_sig = (o_alu_result == 32'b0) ? 1'b1 : 1'b0;

endmodule
