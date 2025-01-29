module RAT (
input clk,rst, write, free,
input [4:0] dest_in, tag_in, rs_in, rt_in, tag_done,
output [4:0] rs_out, rt_out
);

reg [4:0] tags [31:0];
reg [31:0] allocated ; //this is set to zero if the tag points to a register and set to 1 if the tag points to an ROB entry

always @(posedge clk, negedge rst) begin
	integer i;
	if(~rst) begin
		allocated = 32'b0;
		
		for(i=0; i<32; i = i + 1) begin
			tags[i] = i[4:0];
		end
	end
	else begin 
		if (write) begin
			tags[dest_in] = tag_in;
		end
		if (free && allocated[tag_done] == 1) begin
			allocated[tag_done] = 0;
			tags[tag_done] = tag_done;
		end
		else;
	end 
end

assign rs_out = tags[rs_in];
assign rt_out = tags[rt_in];

endmodule