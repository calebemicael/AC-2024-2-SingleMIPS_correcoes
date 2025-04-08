module instruction_memory(clk, reset, read_address, instruction_out);
    input clk, reset;
    input [31:0] read_address;
    integer i;
    integer k;
    output [31:0] instruction_out;

    reg [31:0] I_MEM [63:0];

    assign instruction_out = I_MEM[read_address];

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            begin
                for(k = 0; k < 64; k=k+1)begin
                    I_MEM[k] <= 32'b00;
                end
            end
        end

       else begin

           I_MEM[4]  = 32'b000000_10011_10011_01001_00000_100000; //add $t1, $s3, $s3
           I_MEM[8]  = 32'b000000_01001_01001_01001_00000_100000;
           I_MEM[12]  = 32'b000000_01001_10110_01001_00000_100000; //add $t1, $s3, $s3
           I_MEM[16]  = 32'b000000_10011_10011_01001_00000_100000; //add $t1, $s3, $s3

        end
    end 

endmodule