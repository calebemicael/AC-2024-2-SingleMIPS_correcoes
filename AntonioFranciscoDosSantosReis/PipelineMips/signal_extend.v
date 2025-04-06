module signal_extend(instruction, bits_extends);
    input [15:0] instruction;
    output wire[31:0] bits_extends;

    
    assign bits_extends = {{16{instruction[15]}}, instruction};  

endmodule