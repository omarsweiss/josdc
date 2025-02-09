module RAT (
input clk,rst, write, free, free2,
input [4:0] dest_in, tag_in, rs_in, rt_in, tag_done, tag_done2,
output reg [4:0]  rs_out, rt_out,
output reg allocated_rs, allocated_rt
);

reg [4:0] tags [31:0];
reg allocated [31:0] ; //this is set to zero if the tag points to a register and set to 1 if the tag points to an ROB entry

always @(posedge clk, negedge rst) begin : name
	integer i;
	if(~rst) begin
		
		
		for(i=0; i<32; i = i + 1) begin
			tags[i] = i[4:0];
			allocated[i] = 1'b0;
		end
	end
	
	else begin 
		rs_out = tags[rs_in];
		rt_out = tags[rt_in];
		
		
		if (free && allocated[tag_done] == 1) begin
			allocated[tag_done] = 0;
			tags[tag_done] = tag_done;
		end
		if (free2 && allocated[tag_done2] == 1) begin
			allocated[tag_done2] = 0;
			tags[tag_done2] = tag_done;
		end
		
		if (write) begin
			
			tags[dest_in] = tag_in;
			allocated[dest_in] = 1'b1;
		end
		else;
		allocated_rs = allocated[rs_in];
		allocated_rt = allocated[rt_in];
		
	end 
end


endmodule