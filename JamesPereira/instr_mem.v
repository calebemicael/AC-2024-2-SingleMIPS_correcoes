module instr_mem (
    input [15:0] pc,           
    output [15:0] instruction   
);
    reg [15:0] mem [255:0]; 

    initial begin
        $readmemb("program.mem", mem);
    end

    assign instruction = mem[pc[8:1]]; 
endmodule
