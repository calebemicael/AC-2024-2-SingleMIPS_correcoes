module Adder32(
    input wire [31:0] i_op_a,           // Operando A
    input wire [31:0] i_op_b,           // Operando B
    output wire [31:0] o_result         // Resultado da soma
);

    assign o_result = i_op_a + i_op_b;            // Soma A + B

endmodule
