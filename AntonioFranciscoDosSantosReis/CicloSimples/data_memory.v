module data_Memory(address, write_Data, memRead, memWrite, clk, reset, read_Data);  
    input memRead, memWrite, clk, reset;
    input [31:0] address, write_Data;
    integer i;
    output [31:0] read_Data;

    reg [31:0] D_MEM [63:0];

    always@(posedge clk or posedge reset)begin
        if(reset)begin
        
            D_MEM[0]  = 0;
            D_MEM[1]  = 4;
            D_MEM[2]  = 8;
            D_MEM[3]  = 12;
            D_MEM[4]  = 26;
            D_MEM[5]  = 87;
            D_MEM[6]  = 29;
            D_MEM[7]  = 47;
            D_MEM[8]  = 59;
            D_MEM[9]  = 24;
            D_MEM[10] = 47;
            D_MEM[11] = 36;
            D_MEM[12] = 67;
            D_MEM[13] = 48;
            D_MEM[14] = 0;
            D_MEM[15] = 0;
            D_MEM[16] = 74;
            D_MEM[17] = 80;
            D_MEM[18] = 94;
            D_MEM[19] = 2;
            D_MEM[20] = 4;
            D_MEM[21] = 0;
            D_MEM[22] = 0;
            D_MEM[23] = 0;
            D_MEM[24] = 0;
            D_MEM[25] = 0;
            D_MEM[26] = 0;
            D_MEM[27] = 0;
            D_MEM[28] = 0;
            D_MEM[29] = 0;
            D_MEM[30] = 0;
            D_MEM[31] = 0;
            D_MEM[32] = 0;
            D_MEM[33] = 0;
            D_MEM[34] = 0;
            D_MEM[35] = 0;
            D_MEM[36] = 0;
            D_MEM[37] = 0;
            D_MEM[38] = 0;
            D_MEM[39] = 0;
            D_MEM[40] = 0;
            D_MEM[41] = 0;
            D_MEM[42] = 0;
            D_MEM[43] = 0;
            D_MEM[44] = 0;
            D_MEM[45] = 0;
            D_MEM[46] = 0;
            D_MEM[47] = 0;
            D_MEM[48] = 0;
            D_MEM[49] = 0;
            D_MEM[50] = 0;
            D_MEM[51] = 0;
            D_MEM[52] = 0;
            D_MEM[53] = 0;
            D_MEM[54] = 0;
            D_MEM[55] = 0;
            D_MEM[56] = 0;
            D_MEM[57] = 0;
            D_MEM[58] = 0;
            D_MEM[59] = 0;
            D_MEM[60] = 0;
            D_MEM[61] = 0;
            D_MEM[62] = 0;
            D_MEM[63] = 0;

        end
        else if(memWrite)begin
            D_MEM[address] <= write_Data;
        end
    end

    assign read_Data = (memRead) ? D_MEM[address] : 32'b0;

endmodule