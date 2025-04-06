module multiALUSrc (
    input [31:0] rt,                  
    input [31:0] sinalImediato,   
    input wire ALUSrc,                   
    output reg [31:0] entrada2ALU     
);

    always @* begin
        if (ALUSrc)
            entrada2ALU = sinalImediato; 
        else
            entrada2ALU = rt;            
    end
endmodule;