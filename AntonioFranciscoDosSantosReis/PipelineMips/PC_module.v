module pc_counter(clk, reset, enable, pc_in, pc_out);
    input clk;
    input reset;
    input enable;
    input [31:0] pc_in;
    output reg [31:0] pc_out;

    always @(posedge clk or posedge reset)begin
        if(reset)begin
            pc_out <= 32'b0;
        end
        else if(~enable)begin
            pc_out <=pc_in;
        end
    end

endmodule

module PC_PLUS4(
    input [31:0] pc_out, 
    output [31:0] pc_outplus
);

    assign pc_outplus = pc_out + 4;

endmodule


