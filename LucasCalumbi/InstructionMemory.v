
module InstructionMemory(
    input wire [31:0] i_address,    
    output wire [31:0] o_instruction 
);

    reg [31:0] r_memory [255:0];

    initial begin
        $readmemb("program.bin",r_memory);
    end
 
    assign o_instruction = r_memory[i_address[9:2]]; 
endmodule
