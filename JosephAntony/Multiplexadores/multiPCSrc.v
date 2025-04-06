module multiPCSrc (pc_add4, branch_add, Branch, proxPC);
    input [31:0] pc_add4, branch_add;
    input Branch;
    output [31:0] proxPC;

    assign proxPC = Branch ? branch_add : pc_add4;

endmodule