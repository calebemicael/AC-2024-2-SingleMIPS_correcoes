module ControlUnit(
  input wire [5:0] OpCode,
  output reg [9:0] ControlSignals  // Mudamos para `reg`
);

  always @(*) begin
    case (OpCode)
      6'b000000: ControlSignals = 10'b0100100010; // R-format
      6'b100011: ControlSignals = 10'b0011110000; // lw
      6'b101011: ControlSignals = 10'b0010001000; // sw
      6'b000100: ControlSignals = 10'b0000000101; // beq
      6'b000010: ControlSignals = 10'b1000000000; // j
      6'b001000: ControlSignals = 10'b0010100000; // addi
      default:   ControlSignals = 10'b0000000000; // Default: nenhuma operação
    endcase
  end

endmodule

