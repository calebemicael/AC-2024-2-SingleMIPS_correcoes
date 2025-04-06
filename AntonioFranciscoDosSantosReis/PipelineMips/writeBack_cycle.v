`include "auxiliar.v"


module writeBack_cycle(RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW, ResutW);
    input RegWriteW, MemtoRegW;
    input [31:0] ALUOutW, ReadDataW;
    input [4:0] WriteRegW;
    output RegWriteW_back;
    output [4:0] WriteRegW_Hazard;
    output [31:0] ResultW;
    


    mux1 m (
            .A(ALUOutW), 
            .B(ReadDataW), 
            .sel1(MemtoRegW), 
            .out(ResultW)
            );

    assign WriteRegW_Hazard = WriteRegW;
    assign RegWrite_back = RegWriteW;


endmodule