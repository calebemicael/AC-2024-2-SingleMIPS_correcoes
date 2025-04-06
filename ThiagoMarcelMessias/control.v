module control( 
    input [5:0] opcode,  
    input reset,         
    output reg [1:0] reg_dst,  
    output reg [1:0] mem_to_reg,  
    output reg [1:0] alu_op,  
    output reg jump,  
    output reg branch,  
    output reg mem_read,  
    output reg mem_write,  
    output reg alu_src,  
    output reg reg_write,  
    output reg sign_or_zero  
);

    always @(*) begin  
        if (reset == 1'b1) begin  
            // Sinais de controle padrão no reset
            reg_dst = 2'b00;  
            mem_to_reg = 2'b00;  
            alu_op = 2'b00;  
            jump = 1'b0;  
            branch = 1'b0;  
            mem_read = 1'b0;  
            mem_write = 1'b0;  
            alu_src = 1'b0;  
            reg_write = 1'b0;  
            sign_or_zero = 1'b1;   
        end  
        else begin  
            case(opcode)   
                6'b000000: begin  // R-type (Ex: add, sub, and, or, etc)
                    reg_dst = 2'b01;  
                    mem_to_reg = 2'b00;  
                    alu_op = 2'b10;  
                    jump = 1'b0;  
                    branch = 1'b0;  
                    mem_read = 1'b0;  
                    mem_write = 1'b0;  
                    alu_src = 1'b0;  
                    reg_write = 1'b1;  
                    sign_or_zero = 1'b1;  
                end  
                6'b100011: begin  // lw (Load Word)
                    reg_dst = 2'b00;  
                    mem_to_reg = 2'b01;  
                    alu_op = 2'b00;  
                    jump = 1'b0;  
                    branch = 1'b0;  
                    mem_read = 1'b1;  
                    mem_write = 1'b0;  
                    alu_src = 1'b1;  
                    reg_write = 1'b1;  
                    sign_or_zero = 1'b1;  
                end  
                6'b101011: begin  // sw (Store Word)
                    reg_dst = 2'b00;  
                    mem_to_reg = 2'b00;  
                    alu_op = 2'b00;  
                    jump = 1'b0;  
                    branch = 1'b0;  
                    mem_read = 1'b0;  
                    mem_write = 1'b1;  
                    alu_src = 1'b1;  
                    reg_write = 1'b0;  
                    sign_or_zero = 1'b1;  
                end  
                6'b000100: begin  // beq (Branch if Equal)
                    reg_dst = 2'b00;  
                    mem_to_reg = 2'b00;  
                    alu_op = 2'b01;  
                    jump = 1'b0;  
                    branch = 1'b1;  
                    mem_read = 1'b0;  
                    mem_write = 1'b0;  
                    alu_src = 1'b0;  
                    reg_write = 1'b0;  
                    sign_or_zero = 1'b1;  
                end  
                6'b000010: begin  // j (Jump)
                    reg_dst = 2'b00; 
                    mem_to_reg = 2'b00;  
                    alu_op = 2'b11;  
                    jump = 1'b1;  
                    branch = 1'b0;  
                    mem_read = 1'b0;  
                    mem_write = 1'b0;  
                    alu_src = 1'b0;  
                    reg_write = 1'b0;  
                    sign_or_zero = 1'b1;  
                end  
                6'b000011: begin  
                    reg_dst = 2'b10; 
                    mem_to_reg = 2'b10;  
                    alu_op = 2'b00;  
                    jump = 1'b1;  
                    branch = 1'b0;  
                    mem_read = 1'b0;  
                    mem_write = 1'b0;  
                    alu_src = 1'b0;  
                    reg_write = 1'b1;  
                    sign_or_zero = 1'b1;  
                end  
                6'b001000: begin  // addi (Add Immediate)
                    reg_dst = 2'b00; 
                    mem_to_reg = 2'b00;  
                    alu_op = 2'b00;  
                    jump = 1'b0;  
                    branch = 1'b0;  
                    mem_read = 1'b0;  
                    mem_write = 1'b0;  
                    alu_src = 1'b1;  
                    reg_write = 1'b1;  
                    sign_or_zero = 1'b1;  
                end  
                default: begin  // Default (Caso para instrução inválida)
                    reg_dst = 2'b00;  
                    mem_to_reg = 2'b00;  
                    alu_op = 2'b00;  
                    jump = 1'b0;  
                    branch = 1'b0;  
                    mem_read = 1'b0;  
                    mem_write = 1'b0;  
                    alu_src = 1'b0;  
                    reg_write = 1'b0;  
                    sign_or_zero = 1'b1;  
                end  
            endcase  
        end  
    end  
endmodule