module AluControl(
    input wire [1:0] ALUOperation,  // ALU OP  
    input wire [5:0] funct,         // Campo funct  
    output reg [3:0] regout,
    output wire [3:0] out           // Operação da ALU
);

    always @(*) begin 
      
      casez ({ALUOperation, funct}) // Avaliação 
        {2'b00, 6'b??????}: regout = 4'b0010; 
        {2'b01, 6'b??????}: regout = 4'b0110;
        {2'b10, 6'b??0000}: regout = 4'b0010;
        {2'b10, 6'b??0010}: regout = 4'b0110;
        {2'b10, 6'b??0100}: regout = 4'b0000;
        {2'b10, 6'b??0101}: regout = 4'b0001;
        {2'b10, 6'b??1010}: regout = 4'b0111; 
        default: regout = 4'b0000; 
      endcase

    end
  
  	assign out = regout;

endmodule