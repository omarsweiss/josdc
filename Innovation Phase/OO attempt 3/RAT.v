module RAT ( input clk, input rst,
input stall, RegWrite1, RegWrite2, commit1, commit2, alu1_wr, alu2_wr, ld1_wr, ld2_wr,
input [4:0] alu1_res_tag, alu2_res_tag, ld1_res_tag, ld2_res_tag, alu1_dest, alu2_dest, ld1_dest, ld2_dest, commit1_addr,
input [4:0] commit2_addr, rs1, rt1, rs2, rt2, tag1, tag2, DestReg1, DestReg2, commit1_tag, commit2_tag,





output rs1_ready, rt1_ready, rs2_ready, rt2_ready, rs1_rob, rt1_rob, rs2_rob, rt2_rob,
output [4:0] rs1_tag, rt1_tag, rs2_tag, rt2_tag, dest1_tag, dest2_tag


    
);



reg ready[31:0];
reg rob[31:0];
reg [4:0] tags [31:0];

assign rs1_tag = tags[rs1];
assign rs1_ready = ready[rs1];
assign rs1_rob  = rob[rs1];

assign rs2_tag = tags[rs2];
assign rs2_ready = ready[rs2];
assign rs2_rob  = rob[rs2];

assign rt1_tag = tags[rt1];
assign rt1_ready = ready[rt1];
assign rt1_rob  = rob[rt1];

assign rt2_tag = tags[rt2];
assign rt2_ready = ready[rt2];
assign rt2_rob  = rob[rt2];

assign dest1_tag = tags[DestReg1];
assign dest2_tag = tags[DestReg2];

always @(posedge clk , negedge rst) begin : name
    integer i;

    if (~rst) begin
        for (i = 0; i<32; i=i+1 ) begin
            tags[i] <=0;
            ready[i]<=1;
            rob[i]<=0;
        end
    end
    else begin
        if (RegWrite1 && ~((DestReg1 != DestReg2)&& RegWrite2) && ~stall) begin
            tags[DestReg1] <= tag1;
            ready[DestReg1] <= 1'b0;
            rob[DestReg1] <= 1'b0;
                
        end
        if(RegWrite2 && ~stall) begin
            tags[DestReg2] <= tag2;
            ready[DestReg2] <= 1'b0;
            rob[DestReg2] <= 1'b0;
        end



        if(~rob[alu1_dest] && (tags[alu1_dest] == alu1_res_tag) && ~((alu1_dest == DestReg1) && RegWrite1 && ~stall) && ~((alu1_dest == DestReg2) && RegWrite2 && ~stall) && alu1_wr) begin
            rob[alu1_dest] <= 1'b1;
        end 
        if(~rob[alu2_dest] && (tags[alu2_dest] == alu2_res_tag) && ~((alu2_dest == DestReg1) && RegWrite1 && ~stall) && ~((alu2_dest == DestReg2) && RegWrite2 && ~stall) && alu2_wr) begin
            rob[alu2_dest] <= 1'b1;
        end
        if(~rob[ld1_dest] && (tags[ld1_dest] == ld1_res_tag) && ~((ld1_dest == DestReg1) && RegWrite1 && ~stall) && ~((ld1_dest == DestReg2) && RegWrite2 && ~stall) && ld1_wr) begin
            rob[ld1_dest] <= 1'b1;
        end 
        if(~rob[ld2_dest] && (tags[ld2_dest] == ld2_res_tag) && ~((ld2_dest == DestReg1) && RegWrite1 && ~stall) && ~((ld2_dest == DestReg2) && RegWrite2 && ~stall) && ld2_wr) begin
            rob[ld2_dest] <= 1'b1;
        end
        if(rob[commit1_addr] && commit1 && (commit1_tag == tags[commit1_addr]) && ~((commit1_addr == DestReg1) && RegWrite1 && ~stall) && ~((commit1_addr == DestReg2) && RegWrite2 && ~stall)) begin
            ready[commit1_addr] <= 1'b1;
        end
        if(rob[commit2_addr] && commit2 && (commit2_tag == tags[commit2_addr]) && ~((commit2_addr == DestReg1) && RegWrite1 && ~stall) && ~((commit2_addr == DestReg2) && RegWrite2 && ~stall)) begin
            ready[commit2_addr] <= 1'b1;
        end
    end
    
end

endmodule //RAT