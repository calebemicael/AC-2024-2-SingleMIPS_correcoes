module half_adder (
    input a,
    input b,
    output sum,
    output carry
);
    xor (sum, a, b);
    and (carry, a, b);
endmodule

module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire s1, c1, c2;

    half_adder ha1 (.a(a), .b(b), .sum(s1), .carry(c1));
    half_adder ha2 (.a(s1), .b(cin), .sum(sum), .carry(c2));
    or (cout, c1, c2);
endmodule

module adder_32bit (
    input [31:0] a,
    input [31:0] b,
    input cin,
    output [31:0] sum,
    output cout
);
    wire [31:0] carry;
    
    full_adder fa0  (.a(a[0]), .b(b[0]), .cin(cin),       .sum(sum[0]),  .cout(carry[1]));
    full_adder fa1  (.a(a[1]), .b(b[1]), .cin(carry[1]), .sum(sum[1]),  .cout(carry[2]));
    full_adder fa2  (.a(a[2]), .b(b[2]), .cin(carry[2]), .sum(sum[2]),  .cout(carry[3]));
    full_adder fa3  (.a(a[3]), .b(b[3]), .cin(carry[3]), .sum(sum[3]),  .cout(carry[4]));
    full_adder fa4  (.a(a[4]), .b(b[4]), .cin(carry[4]), .sum(sum[4]),  .cout(carry[5]));
    full_adder fa5  (.a(a[5]), .b(b[5]), .cin(carry[5]), .sum(sum[5]),  .cout(carry[6]));
    full_adder fa6  (.a(a[6]), .b(b[6]), .cin(carry[6]), .sum(sum[6]),  .cout(carry[7]));
    full_adder fa7  (.a(a[7]), .b(b[7]), .cin(carry[7]), .sum(sum[7]),  .cout(carry[8]));
    full_adder fa8  (.a(a[8]), .b(b[8]), .cin(carry[8]), .sum(sum[8]),  .cout(carry[9]));
    full_adder fa9  (.a(a[9]), .b(b[9]), .cin(carry[9]), .sum(sum[9]),  .cout(carry[10]));
    full_adder fa10 (.a(a[10]), .b(b[10]), .cin(carry[10]), .sum(sum[10]), .cout(carry[11]));
    full_adder fa11 (.a(a[11]), .b(b[11]), .cin(carry[11]), .sum(sum[11]), .cout(carry[12]));
    full_adder fa12 (.a(a[12]), .b(b[12]), .cin(carry[12]), .sum(sum[12]), .cout(carry[13]));
    full_adder fa13 (.a(a[13]), .b(b[13]), .cin(carry[13]), .sum(sum[13]), .cout(carry[14]));
    full_adder fa14 (.a(a[14]), .b(b[14]), .cin(carry[14]), .sum(sum[14]), .cout(carry[15]));
    full_adder fa15 (.a(a[15]), .b(b[15]), .cin(carry[15]), .sum(sum[15]), .cout(carry[16]));
    full_adder fa16 (.a(a[16]), .b(b[16]), .cin(carry[16]), .sum(sum[16]), .cout(carry[17]));
    full_adder fa17 (.a(a[17]), .b(b[17]), .cin(carry[17]), .sum(sum[17]), .cout(carry[18]));
    full_adder fa18 (.a(a[18]), .b(b[18]), .cin(carry[18]), .sum(sum[18]), .cout(carry[19]));
    full_adder fa19 (.a(a[19]), .b(b[19]), .cin(carry[19]), .sum(sum[19]), .cout(carry[20]));
    full_adder fa20 (.a(a[20]), .b(b[20]), .cin(carry[20]), .sum(sum[20]), .cout(carry[21]));
    full_adder fa21 (.a(a[21]), .b(b[21]), .cin(carry[21]), .sum(sum[21]), .cout(carry[22]));
    full_adder fa22 (.a(a[22]), .b(b[22]), .cin(carry[22]), .sum(sum[22]), .cout(carry[23]));
    full_adder fa23 (.a(a[23]), .b(b[23]), .cin(carry[23]), .sum(sum[23]), .cout(carry[24]));
    full_adder fa24 (.a(a[24]), .b(b[24]), .cin(carry[24]), .sum(sum[24]), .cout(carry[25]));
    full_adder fa25 (.a(a[25]), .b(b[25]), .cin(carry[25]), .sum(sum[25]), .cout(carry[26]));
    full_adder fa26 (.a(a[26]), .b(b[26]), .cin(carry[26]), .sum(sum[26]), .cout(carry[27]));
    full_adder fa27 (.a(a[27]), .b(b[27]), .cin(carry[27]), .sum(sum[27]), .cout(carry[28]));
    full_adder fa28 (.a(a[28]), .b(b[28]), .cin(carry[28]), .sum(sum[28]), .cout(carry[29]));
    full_adder fa29 (.a(a[29]), .b(b[29]), .cin(carry[29]), .sum(sum[29]), .cout(carry[30]));
    full_adder fa30 (.a(a[30]), .b(b[30]), .cin(carry[30]), .sum(sum[30]), .cout(carry[31]));
    full_adder fa31 (.a(a[31]), .b(b[31]), .cin(carry[31]), .sum(sum[31]), .cout(cout));
endmodule

module half_subtractor (
    input a,
    input b,
    output diff,
    output borrow
);
    xor (diff, a, b);
    and (borrow, ~a, b);
endmodule

module full_subtractor (
    input a,
    input b,
    input bin,
    output diff,
    output bout
);
    wire d1, b1, b2;

    half_subtractor hs1 (.a(a), .b(b), .diff(d1), .borrow(b1));
    half_subtractor hs2 (.a(d1), .b(bin), .diff(diff), .borrow(b2));
    or (bout, b1, b2);
endmodule

module subtractor_32bit (
    input [31:0] a,
    input [31:0] b,
    input bin,
    output [31:0] diff,
    output bout
);
    wire [31:0] borrow;

    full_subtractor fs0  (.a(a[0]),  .b(b[0]),  .bin(bin),        .diff(diff[0]),  .bout(borrow[1]));
    full_subtractor fs1  (.a(a[1]),  .b(b[1]),  .bin(borrow[1]),  .diff(diff[1]),  .bout(borrow[2]));
    full_subtractor fs2  (.a(a[2]),  .b(b[2]),  .bin(borrow[2]),  .diff(diff[2]),  .bout(borrow[3]));
    full_subtractor fs3  (.a(a[3]),  .b(b[3]),  .bin(borrow[3]),  .diff(diff[3]),  .bout(borrow[4]));
    full_subtractor fs4  (.a(a[4]),  .b(b[4]),  .bin(borrow[4]),  .diff(diff[4]),  .bout(borrow[5]));
    full_subtractor fs5  (.a(a[5]),  .b(b[5]),  .bin(borrow[5]),  .diff(diff[5]),  .bout(borrow[6]));
    full_subtractor fs6  (.a(a[6]),  .b(b[6]),  .bin(borrow[6]),  .diff(diff[6]),  .bout(borrow[7]));
    full_subtractor fs7  (.a(a[7]),  .b(b[7]),  .bin(borrow[7]),  .diff(diff[7]),  .bout(borrow[8]));
    full_subtractor fs8  (.a(a[8]),  .b(b[8]),  .bin(borrow[8]),  .diff(diff[8]),  .bout(borrow[9]));
    full_subtractor fs9  (.a(a[9]),  .b(b[9]),  .bin(borrow[9]),  .diff(diff[9]),  .bout(borrow[10]));
    full_subtractor fs10 (.a(a[10]), .b(b[10]), .bin(borrow[10]), .diff(diff[10]), .bout(borrow[11]));
    full_subtractor fs11 (.a(a[11]), .b(b[11]), .bin(borrow[11]), .diff(diff[11]), .bout(borrow[12]));
    full_subtractor fs12 (.a(a[12]), .b(b[12]), .bin(borrow[12]), .diff(diff[12]), .bout(borrow[13]));
    full_subtractor fs13 (.a(a[13]), .b(b[13]), .bin(borrow[13]), .diff(diff[13]), .bout(borrow[14]));
    full_subtractor fs14 (.a(a[14]), .b(b[14]), .bin(borrow[14]), .diff(diff[14]), .bout(borrow[15]));
    full_subtractor fs15 (.a(a[15]), .b(b[15]), .bin(borrow[15]), .diff(diff[15]), .bout(borrow[16]));
    full_subtractor fs16 (.a(a[16]), .b(b[16]), .bin(borrow[16]), .diff(diff[16]), .bout(borrow[17]));
    full_subtractor fs17 (.a(a[17]), .b(b[17]), .bin(borrow[17]), .diff(diff[17]), .bout(borrow[18]));
    full_subtractor fs18 (.a(a[18]), .b(b[18]), .bin(borrow[18]), .diff(diff[18]), .bout(borrow[19]));
    full_subtractor fs19 (.a(a[19]), .b(b[19]), .bin(borrow[19]), .diff(diff[19]), .bout(borrow[20]));
    full_subtractor fs20 (.a(a[20]), .b(b[20]), .bin(borrow[20]), .diff(diff[20]), .bout(borrow[21]));
    full_subtractor fs21 (.a(a[21]), .b(b[21]), .bin(borrow[21]), .diff(diff[21]), .bout(borrow[22]));
    full_subtractor fs22 (.a(a[22]), .b(b[22]), .bin(borrow[22]), .diff(diff[22]), .bout(borrow[23]));
    full_subtractor fs23 (.a(a[23]), .b(b[23]), .bin(borrow[23]), .diff(diff[23]), .bout(borrow[24]));
    full_subtractor fs24 (.a(a[24]), .b(b[24]), .bin(borrow[24]), .diff(diff[24]), .bout(borrow[25]));
    full_subtractor fs25 (.a(a[25]), .b(b[25]), .bin(borrow[25]), .diff(diff[25]), .bout(borrow[26]));
    full_subtractor fs26 (.a(a[26]), .b(b[26]), .bin(borrow[26]), .diff(diff[26]), .bout(borrow[27]));
    full_subtractor fs27 (.a(a[27]), .b(b[27]), .bin(borrow[27]), .diff(diff[27]), .bout(borrow[28]));
    full_subtractor fs28 (.a(a[28]), .b(b[28]), .bin(borrow[28]), .diff(diff[28]), .bout(borrow[29]));
    full_subtractor fs29 (.a(a[29]), .b(b[29]), .bin(borrow[29]), .diff(diff[29]), .bout(borrow[30]));
    full_subtractor fs30 (.a(a[30]), .b(b[30]), .bin(borrow[30]), .diff(diff[30]), .bout(borrow[31]));
    full_subtractor fs31 (.a(a[31]), .b(b[31]), .bin(borrow[31]), .diff(diff[31]), .bout(bout));
endmodule


module and_ (
    input [31:0] A,
    input [31:0] B,
    output [31:0] R
);
    and and0(R[0], A[0], B[0]);
    and and1(R[1], A[1], B[1]);
    and and2(R[2], A[2], B[2]);
    and and3(R[3], A[3], B[3]);
    and and4(R[4], A[4], B[4]);
    and and5(R[5], A[5], B[5]);
    and and6(R[6], A[6], B[6]);
    and and7(R[7], A[7], B[7]);
    and and8(R[8], A[8], B[8]);
    and and9(R[9], A[9], B[9]);
    and and10(R[10], A[10], B[10]);
    and and11(R[11], A[11], B[11]);
    and and12(R[12], A[12], B[12]);
    and and13(R[13], A[13], B[13]);
    and and14(R[14], A[14], B[14]);
    and and15(R[15], A[15], B[15]);
    and and16(R[16], A[16], B[16]);
    and and17(R[17], A[17], B[17]);
    and and18(R[18], A[18], B[18]);
    and and19(R[19], A[19], B[19]);
    and and20(R[20], A[20], B[20]);
    and and21(R[21], A[21], B[21]);
    and and22(R[22], A[22], B[22]);
    and and23(R[23], A[23], B[23]);
    and and24(R[24], A[24], B[24]);
    and and25(R[25], A[25], B[25]);
    and and26(R[26], A[26], B[26]);
    and and27(R[27], A[27], B[27]);
    and and28(R[28], A[28], B[28]);
    and and29(R[29], A[29], B[29]);
    and and30(R[30], A[30], B[30]);
    and and31(R[31], A[31], B[31]);
endmodule

module nothing_A (
    input [31:0] A,
    output [31:0] R
);
    buf buf0(R[0], A[0]);
    buf buf1(R[1], A[1]);
    buf buf2(R[2], A[2]);
    buf buf3(R[3], A[3]);
    buf buf4(R[4], A[4]);
    buf buf5(R[5], A[5]);
    buf buf6(R[6], A[6]);
    buf buf7(R[7], A[7]);
    buf buf8(R[8], A[8]);
    buf buf9(R[9], A[9]);
    buf buf10(R[10], A[10]);
    buf buf11(R[11], A[11]);
    buf buf12(R[12], A[12]);
    buf buf13(R[13], A[13]);
    buf buf14(R[14], A[14]);
    buf buf15(R[15], A[15]);
    buf buf16(R[16], A[16]);
    buf buf17(R[17], A[17]);
    buf buf18(R[18], A[18]);
    buf buf19(R[19], A[19]);
    buf buf20(R[20], A[20]);
    buf buf21(R[21], A[21]);
    buf buf22(R[22], A[22]);
    buf buf23(R[23], A[23]);
    buf buf24(R[24], A[24]);
    buf buf25(R[25], A[25]);
    buf buf26(R[26], A[26]);
    buf buf27(R[27], A[27]);
    buf buf28(R[28], A[28]);
    buf buf29(R[29], A[29]);
    buf buf30(R[30], A[30]);
    buf buf31(R[31], A[31]);
endmodule

module or_ (
    input [31:0] A,
    input [31:0] B,
    output [31:0] R
);
    or or0(R[0], A[0], B[0]);
    or or1(R[1], A[1], B[1]);
    or or2(R[2], A[2], B[2]);
    or or3(R[3], A[3], B[3]);
    or or4(R[4], A[4], B[4]);
    or or5(R[5], A[5], B[5]);
    or or6(R[6], A[6], B[6]);
    or or7(R[7], A[7], B[7]);
    or or8(R[8], A[8], B[8]);
    or or9(R[9], A[9], B[9]);
    or or10(R[10], A[10], B[10]);
    or or11(R[11], A[11], B[11]);
    or or12(R[12], A[12], B[12]);
    or or13(R[13], A[13], B[13]);
    or or14(R[14], A[14], B[14]);
    or or15(R[15], A[15], B[15]);
    or or16(R[16], A[16], B[16]);
    or or17(R[17], A[17], B[17]);
    or or18(R[18], A[18], B[18]);
    or or19(R[19], A[19], B[19]);
    or or20(R[20], A[20], B[20]);
    or or21(R[21], A[21], B[21]);
    or or22(R[22], A[22], B[22]);
    or or23(R[23], A[23], B[23]);
    or or24(R[24], A[24], B[24]);
    or or25(R[25], A[25], B[25]);
    or or26(R[26], A[26], B[26]);
    or or27(R[27], A[27], B[27]);
    or or28(R[28], A[28], B[28]);
    or or29(R[29], A[29], B[29]);
    or or30(R[30], A[30], B[30]);
    or or31(R[31], A[31], B[31]);
endmodule

module not_A (
    input [31:0] A,
    output [31:0] R
);
    not not0(R[0], A[0]);
    not not1(R[1], A[1]);
    not not2(R[2], A[2]);
    not not3(R[3], A[3]);
    not not4(R[4], A[4]);
    not not5(R[5], A[5]);
    not not6(R[6], A[6]);
    not not7(R[7], A[7]);
    not not8(R[8], A[8]);
    not not9(R[9], A[9]);
    not not10(R[10], A[10]);
    not not11(R[11], A[11]);
    not not12(R[12], A[12]);
    not not13(R[13], A[13]);
    not not14(R[14], A[14]);
    not not15(R[15], A[15]);
    not not16(R[16], A[16]);
    not not17(R[17], A[17]);
    not not18(R[18], A[18]);
    not not19(R[19], A[19]);
    not not20(R[20], A[20]);
    not not21(R[21], A[21]);
    not not22(R[22], A[22]);
    not not23(R[23], A[23]);
    not not24(R[24], A[24]);
    not not25(R[25], A[25]);
    not not26(R[26], A[26]);
    not not27(R[27], A[27]);
    not not28(R[28], A[28]);
    not not29(R[29], A[29]);
    not not30(R[30], A[30]);
    not not31(R[31], A[31]);
endmodule

module xnor_ (
    input [31:0] A,
    input [31:0] B,
    output [31:0] R
);
    xnor xnor0(R[0], A[0], B[0]);
    xnor xnor1(R[1], A[1], B[1]);
    xnor xnor2(R[2], A[2], B[2]);
    xnor xnor3(R[3], A[3], B[3]);
    xnor xnor4(R[4], A[4], B[4]);
    xnor xnor5(R[5], A[5], B[5]);
    xnor xnor6(R[6], A[6], B[6]);
    xnor xnor7(R[7], A[7], B[7]);
    xnor xnor8(R[8], A[8], B[8]);
    xnor xnor9(R[9], A[9], B[9]);
    xnor xnor10(R[10], A[10], B[10]);
    xnor xnor11(R[11], A[11], B[11]);
    xnor xnor12(R[12], A[12], B[12]);
    xnor xnor13(R[13], A[13], B[13]);
    xnor xnor14(R[14], A[14], B[14]);
    xnor xnor15(R[15], A[15], B[15]);
    xnor xnor16(R[16], A[16], B[16]);
    xnor xnor17(R[17], A[17], B[17]);
    xnor xnor18(R[18], A[18], B[18]);
    xnor xnor19(R[19], A[19], B[19]);
    xnor xnor20(R[20], A[20], B[20]);
    xnor xnor21(R[21], A[21], B[21]);
    xnor xnor22(R[22], A[22], B[22]);
    xnor xnor23(R[23], A[23], B[23]);
    xnor xnor24(R[24], A[24], B[24]);
    xnor xnor25(R[25], A[25], B[25]);
    xnor xnor26(R[26], A[26], B[26]);
    xnor xnor27(R[27], A[27], B[27]);
    xnor xnor28(R[28], A[28], B[28]);
    xnor xnor29(R[29], A[29], B[29]);
    xnor xnor30(R[30], A[30], B[30]);
    xnor xnor31(R[31], A[31], B[31]);
endmodule

module not_B (
    input [31:0] B,
    output [31:0] R
);
    not not0(R[0], B[0]);
    not not1(R[1], B[1]);
    not not2(R[2], B[2]);
    not not3(R[3], B[3]);
    not not4(R[4], B[4]);
    not not5(R[5], B[5]);
    not not6(R[6], B[6]);
    not not7(R[7], B[7]);
    not not8(R[8], B[8]);
    not not9(R[9], B[9]);
    not not10(R[10], B[10]);
    not not11(R[11], B[11]);
    not not12(R[12], B[12]);
    not not13(R[13], B[13]);
    not not14(R[14], B[14]);
    not not15(R[15], B[15]);
    not not16(R[16], B[16]);
    not not17(R[17], B[17]);
    not not18(R[18], B[18]);
    not not19(R[19], B[19]);
    not not20(R[20], B[20]);
    not not21(R[21], B[21]);
    not not22(R[22], B[22]);
    not not23(R[23], B[23]);
    not not24(R[24], B[24]);
    not not25(R[25], B[25]);
    not not26(R[26], B[26]);
    not not27(R[27], B[27]);
    not not28(R[28], B[28]);
    not not29(R[29], B[29]);
    not not30(R[30], B[30]);
    not not31(R[31], B[31]);
endmodule

module ula(
    input [7:0] f, 
    input [31:0] A, B,
    output [31:0] RES,
    output Zero
);

    wire [31:0] sum_res, subtract_res, and_res, nothing_A_res, or_res, not_A_res, xnor_res, not_B_res;
    wire sum_, subtract_, and__, nothing_A_, or__, not_A_, xnor__, not_B_;

    adder_32bit sum_inst (.a(A), .b(B), .cin(1'b0), .sum(sum_res), .cout());
    subtractor_32bit subtract_inst (.a(A), .b(B), .bin(1'b0), .diff(subtract_res), .bout());
    and_ and_inst (.A(A), .B(B), .R(and_res));
    nothing_A nothing_A_inst (.A(A), .R(nothing_A_res));
    or_ or_inst (.A(A), .B(B), .R(or_res));
    not_A not_A_inst (.A(A), .R(not_A_res));
    xnor_ xnor_inst (.A(A), .B(B), .R(xnor_res));
    not_B not_B_inst (.B(B), .R(not_B_res));

    assign sum_ = (~f[0] & ~f[1] & ~f[2]);      
    assign subtract_ = (f[0] & ~f[1] & ~f[2]);       
    assign and__ = (~f[0] & f[1] & ~f[2]);       
    assign nothing_A_ = (f[0] & f[1] & ~f[2]);       
    assign or__ = (~f[0] & ~f[1] & f[2]);      
    assign not_A_ = (f[0] & ~f[1] & f[2]);       
    assign xnor__ = (~f[0] & f[1] & f[2]);        
    assign not_B_ = (f[0] & f[1] & f[2]);

    assign RES = ({32{sum_}} & sum_res) |
                 ({32{subtract_}} & subtract_res) |
                 ({32{and__}} & and_res) |
                 ({32{nothing_A_}} & nothing_A_res) |
                 ({32{or__}} & or_res) |
                 ({32{not_A_}} & not_A_res) |
                 ({32{xnor__}} & xnor_res) |
                 ({32{not_B_}} & not_B_res);

    assign Zero = (RES == 32'b0);
endmodule




