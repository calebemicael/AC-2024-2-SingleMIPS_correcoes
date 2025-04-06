`include "data_Memory.v"


module memory_cycle(clk, reset, RegWriteM, MemtoRegM, MemWriteM, MemReadM, ALUOutM, WriteDataM, WriteRegM, WriteRegM_Hazard, 
RegWriteW, MemtoRegW, ReadDataW, ALUOutW, WriteRegW);
    input clk, reset, RegWriteM, MemtoRegM, MemWriteM, MemReadM;
    input [31:0] ALUOutM;
    input [31:0] WriteDataM;
    input [4:0] WriteRegM;
    output [4:0]WriteRegM_Hazard;
    output RegWriteW, MemtoRegW;
    output [31:0] ReadDataW, ALUOutW;
    output [4:0] WriteRegW;


    assign WriteRegM_Hazard = WriteRegM;
    wire [31:0] read_Data_wire;


    //declarando registradores intermediários
    reg RegWriteM_r, MemtoRegM_r;
    reg [31:0] ReadDataW_r;
    reg [31:0] ALUOutW_r;
    reg [4:0] WriteRegW_r;

    

    //importando a memoria de dados

    data_Memory d1(
                   .address(ALUOutM), 
                   .write_Data(WriteDataM), 
                   .memRead(MemReadM), 
                   .memWrite(MemWriteM), 
                   .clk(clk), 
                   .reset(reset), 
                   .read_Data(read_Data_wire)
                   );

    always@(posedge clk or posedge reset)begin
        if(reset)begin
            RegWriteM_r <=  1'b0;
            MemtoRegM_r <= 1'b0;
            ReadDataW_r <= 32'b0;
            ALUOutW_r <= 32'b0;
            WriteRegW_r <= 5'b0;
        end begin
            RegWriteM_r <= RegWriteM;
            MemtoRegM_r <= MemtoRegM;
            ReadDataW_r <= read_Data_wire;
            ALUOutW_r <= ALUOutM;
            WriteRegW_r <= WriteRegM;
        end

    end

    assign RegWriteW = RegWriteM_r;
    assign MemtoRegW = MemtoRegM_r;
    assign ReadDataW = ReadDataW_r;
    assign ALUOutW = ALUOutW_r;
    assign WriteRegW = WriteRegW_r;




endmodule