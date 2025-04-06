module multiPCSrc (
    input [31:0] pc_add4,      
    input [31:0] branch_add,   
    input [31:0] jump_addr,    
    input Branch,              
    input Jump,                
    output [31:0] proxPC      
);

    assign proxPC = Jump ? jump_addr : (Branch ? branch_add : pc_add4);

endmodule