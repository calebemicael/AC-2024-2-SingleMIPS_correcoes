module registers (ReadReg1, ReadReg2, WriteReg, WriteData, RegWrite, clock, ReadData1, ReadData2);
    input [4:0] ReadReg1;
    input [4:0] ReadReg2;
    input [4:0] WriteReg;
    input [31:0] WriteData;
    input RegWrite;
    input clock;
    output [31:0] ReadData1;
    output [31:0] ReadData2;
    integer k;

    reg [31:0] register [31:0];//registrando banco de 32reg/32bits 

    
    initial begin  //chegagem de inicializacao nula
        for (k=0; k<32; k+=32) begin
            register[k] = 32'b0;
        end
    
    end

    assign ReadData1 = register [ReadReg1];
    assign ReadData2 = register [ReadReg2];

    always @(posedge clock) begin
        if(RegWrite && WriteReg != 5'b0)
        begin
            register[WriteReg] <= WriteData; 
        end
    end
endmodule