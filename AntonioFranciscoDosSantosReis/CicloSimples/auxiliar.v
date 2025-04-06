module mux1(A, B, sel1, out);
    input sel1;
    input [31:0] A, B;
    output [31:0] out;

    assign out = (sel1==1'b0) ? A : B;

endmodule

module mux2(A2, B2, sel2, out2);
    input sel2;
    input [31:0] A2, B2;
    output [31:0] out2;

    assign out2 = (sel2==1'b0) ? A2 : B2;

endmodule

module muxJump(A, B, sel, out);
    input [31:0] A, B;
    input sel;
    output [31:0] out;

    assign out = (sel==1'b0) ? A : B;

endmodule

module muxSelect_Register(A, B, sel1, out);
    input sel1;
    input [4:0] A, B;
    output [4:0] out;

    assign out = (sel1==1'b0) ? A : B;

endmodule

module and_logic(branch, zero, and_out);
    input branch, zero;
    output and_out;

    assign and_out = branch & zero;

endmodule

module adder(in1, in2, out_adder);
    input [31:0] in1, in2;
    output [31:0] out_adder;

    assign out_adder = in1 + (in2 << 2);

endmodule

module concatBits(in1, in2, out1);
    input [25:0] in1;
    input [3:0] in2;
    output [31:0] out1;

    //wire [27:0] aux;

    //assign aux = in1 << 2;

    assign out1 = {in2, (in1 << 2)};

endmodule