module Mux32(
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire s,
    output reg [31:0]out
);

    always @(*) begin
        if(s) begin
            out <= in1;
        end else begin
            out <=in2;
        end
    end
endmodule

module Mux5(
    input wire [4:0] in1,
    input wire [4:0] in2,
    input wire s,
    output reg [4:0] out
);

    always @(*) begin
        if(s) begin
            out <= in1;
        end else begin
            out <=in2;
        end
    end
endmodule