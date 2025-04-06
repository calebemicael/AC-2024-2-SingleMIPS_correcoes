module ALU (
    input wire [31:0] A, B,  
    input wire [3:0] ALUOperation, 
    output reg [31:0] ALUResult,
    output reg Zero 
);

    always @(*) begin
        case (ALUOperation)
            4'b0000: ALUResult = A & B;  
            4'b0001: ALUResult = A | B;  
            4'b0010: ALUResult = A + B;  
            4'b0110: ALUResult = A - B;  
            4'b0111: ALUResult = (A < B) ? 1 : 0;
            4'b1100: ALUResult = ~(A | B); 
            4'b1101: ALUResult = A ^ B;  
            default: ALUResult = 32'b0;  
        endcase
        
        Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
    end
endmodule
