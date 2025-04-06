module signal_extend(inst, extendbits);
//extensor de sinal de 16 bits para 32 bits
    input [15:0] inst;
    output wire[31:0] extendbits;

    
    assign extendbits = {{16{inst[15]}}, inst};  

endmodule