module ALUcontrol(
    input wire [5:0] funct,
    input wire [1:0] ALUop,
    output reg [3:0] ALUcontrol
);

    always@(*) begin
        casez (ALUop) //LW, SW
            2'b00 : ALUcontrol = 4'b0010; //add
            2'b?1 : ALUcontrol = 4'b0110; //sub
            2'b1? : 
            casez (funct) //Type R
                6'b??0000 : ALUcontrol = 4'b0010; //add
                6'b??0010 : ALUcontrol = 4'b0110; //sub
                6'b??0100 : ALUcontrol = 4'b0000; //and
                6'b??0101 : ALUcontrol = 4'b0001; //or
                6'b??1010 : ALUcontrol = 4'b0111; //slt
            endcase
            default : ALUcontrol = 4'b1111; //no operation
        endcase
    end


endmodule