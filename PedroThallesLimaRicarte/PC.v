module PC(
    input wire clk,
    input wire  reset,
    input wire [31:0] addrValue,
    output wire [31:0] address
);

    reg [31:0] pc;
    assign address = pc;

    always @(posedge clk or posedge reset) begin

        pc <= reset ? 32'b0 : addrValue;
    end 

    

endmodule