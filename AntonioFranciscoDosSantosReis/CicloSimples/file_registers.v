module file_registers(clk, reset, regWrite, Rs1, Rs2, wR, writeData, Rd1, Rd2);

    input clk, reset, regWrite;
    input [4:0] Rs1, Rs2, wR;
    input [31:0] writeData;
    integer k;
    integer s;
    output [31:0] Rd1, Rd2;

    reg [31:0] Registers [31:0];


    always@(posedge clk or posedge reset)begin
        if(reset) begin
        
            Registers[0] = 0;
            Registers[1] = 4;
            Registers[2] = 2;
            Registers[3] = 24;
            Registers[4] = 4;
            Registers[5] = 1;
            Registers[6] = 0;
            Registers[7] = 4;
            Registers[8] = 0; //$t0
            Registers[9] = 10; //$t1
            Registers[10] = 50; //$t2
            Registers[11] = 4; //$t3
            Registers[12] = 2; //$t4
            Registers[13] = 10; //$t5
            Registers[14] = 20; //$t6
            Registers[15] = 30; //$t7
            Registers[16] = 2; //$s0
            Registers[17] = 10; //$s1
            Registers[18] = 0; //$s2
            Registers[19] = 5; //$s3
            Registers[20] = 80; //$s4
            Registers[21] = 4; //$s5
            Registers[22] = 0; //$s6
            Registers[23] = 50; //$s7
            Registers[24] = 60; //$t8
            Registers[25] = 65;//$t9
            Registers[26] = 4;
            Registers[27] = 32;
            Registers[28] = 12;
            Registers[29] = 34;
            Registers[30] = 5;
            Registers[31] = 10;

        end

        else if(regWrite) begin
            Registers[wR] <= writeData;
        end
    end

    assign Rd1 = Registers[Rs1];
    assign Rd2 = Registers[Rs2];

endmodule
