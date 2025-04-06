module InstructionMemory(
    input wire [31:0] Address,
    output wire [31:0] Instruction
);

    reg [31:0] memory [0:1023];  

    initial begin
        memory[0] = 32'h2001000A; 
        memory[1] = 32'h20020014; 
        memory[2] = 32'h00221820;
        memory[3] = 32'h00412022; 
        memory[4] = 32'hAC030000; 
        memory[5] = 32'h8C050000; 
        memory[6] = 32'h10A30002;  
        memory[7] = 32'h0800000A;  
        memory[8] = 32'h20060028;  
        memory[9] = 32'h08000009;  
    end

    assign Instruction = memory[Address[31:2]];

endmodule