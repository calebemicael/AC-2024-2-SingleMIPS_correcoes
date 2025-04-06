module ALUControl (
  input [1:0] ALUOp,       
  input [5:0] funct,       
  output reg [3:0] ALUControl
);

always @(*) begin
  case (ALUOp)
    2'b00: ALUControl = 4'b0010;  // LW ou SW -> ADD
    2'b01: ALUControl = 4'b0110;  // BEQ -> SUB
    2'b10: begin                  // R-type, definido pelo funct
      case (funct)
        6'b100000: ALUControl = 4'b0010;  // ADD
        6'b100010: ALUControl = 4'b0110;  // SUB
        6'b100100: ALUControl = 4'b0000;  // AND
        6'b100101: ALUControl = 4'b0001;  // OR
        6'b101010: ALUControl = 4'b0111;  // SLT
        default:   ALUControl = 4'b0000;  // Operação padrão (NOP)
      endcase
    end
    default: ALUControl = 4'b0000;        // Operação padrão (NOP)
  endcase
end

endmodule
