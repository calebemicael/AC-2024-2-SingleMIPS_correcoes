module ALUControl(
  input wire [5:0] Instruction, 
  input wire [1:0] AluOp,      
  output reg [3:0] Operation  
);

 always @(*) begin
   Operation[3] = 0;  
   Operation[2] = AluOp[0] & (AluOp[1] & Instruction[1]);
   Operation[1] = !AluOp[1] | !Instruction[2];
   Operation[0] = AluOp[1] & (Instruction[3] | Instruction[0]);
 end

endmodule

