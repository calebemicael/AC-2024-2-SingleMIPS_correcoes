// é aqui que mora o perigo
module hazard_unit(
    input [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW,
    input RegWriteM, RegWriteW, MemtoRegE, MemtoRegM, BranchD, RegWriteE,
    output reg StallF, StallD, ForwardAD, ForwardBD, FlushE,
    output reg [1:0] ForwardAE, ForwardBE
);

always @(*) begin

    if ((RsE != 0) && (RsE == WriteRegM) && RegWriteM)
        ForwardAE = 2'b10;
    else if ((RsE != 0) && (RsE == WriteRegW) && RegWriteW)
        ForwardAE = 2'b01;
    else
        ForwardAE = 2'b00;

    if ((RtE != 0) && (RtE == WriteRegM) && RegWriteM)
        ForwardBE = 2'b10;
    else if ((RtE != 0) && (RtE == WriteRegW) && RegWriteW)
        ForwardBE = 2'b01;
    else
        ForwardBE = 2'b00;
end

assign ForwardAD = (RsD != 0) && (RsD == WriteRegM) && RegWriteM;
assign ForwardBD = (RtD != 0) && (RtD == WriteRegM) && RegWriteM;


wire lwstall = (MemtoRegE && ((RsD == RtE) || (RtD == RtE)));
wire branchstall = (BranchD && RegWriteE && ((WriteRegE == RsD) || (WriteRegE == RtD))) ||
                   (BranchD && MemtoRegM && ((WriteRegM == RsD) || (WriteRegM == RtD)));


always @(*) begin
    StallF = lwstall | branchstall;
    StallD = lwstall | branchstall;
    FlushE = lwstall | branchstall;
end

endmodule

