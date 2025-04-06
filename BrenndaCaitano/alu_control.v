module alu_control (
    input [1:0] alu_op,
    input [5:0] funct,
    output reg [2:0] alu_control_signal
);
always @(*) begin
    case (alu_op)
        2'b00: alu_control_signal = 3'b010; // add (lw/sw)
        2'b01: alu_control_signal = 3'b110; // sub (beq)
        2'b10: case (funct) // R-type
            6'b100000: alu_control_signal = 3'b010; // add
            6'b100010: alu_control_signal = 3'b110; // sub
            6'b100100: alu_control_signal = 3'b000; // and
            6'b100101: alu_control_signal = 3'b001; // or
            6'b101010: alu_control_signal = 3'b111; // slt
            default:   alu_control_signal = 3'b010;
        endcase
        default: alu_control_signal = 3'b010;
    endcase
end
endmodule