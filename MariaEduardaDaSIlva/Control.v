module Control (
  input [5:0] opcode,        
  output reg RegDst,
  output reg Branch,
  output reg MemRead,
  output reg MemtoReg,
  output reg [1:0] ALUOp,  
  output reg MemWrite,
  output reg ALUSrc,
  output reg RegWrite,
  output reg Jump
);

always @(*) begin
  RegDst   = 0;
  Branch   = 0;
  MemRead  = 0;
  MemtoReg = 0;
  ALUOp    = 2'b00;
  MemWrite = 0;
  ALUSrc   = 0;
  RegWrite = 0;
  Jump     = 0;

  case (opcode)
    6'b000000: begin // R-type
      RegDst   = 1;
      RegWrite = 1;
      ALUOp    = 2'b10;
    end
    6'b001000: begin // addi
      ALUSrc   = 1;
      RegWrite = 1;
    end
    6'b100011: begin // lw
      ALUSrc   = 1;
      MemtoReg = 1;
      RegWrite = 1;
      MemRead  = 1;
    end
    6'b101011: begin // sw
      ALUSrc   = 1;
      MemWrite = 1;
    end
    6'b000100: begin // beq
      Branch   = 1;
      ALUOp    = 2'b01;
    end
    6'b000010: begin // jump
      Jump = 1;
    end
    default: begin
    end
  endcase
end

endmodule
