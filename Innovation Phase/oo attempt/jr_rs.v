module jr_rs (
input clk, rst, jr_in, alloc,
input [4:0] tag_jr, alu_res_tag, alu_res_tag2, ld_dest,ld_dest2,
input [31:0] value, value2, ld_value,ld_value2,
output reg jr_out,
output reg [9:0] jr_addr);

reg [4:0] tag;

always @(posedge clk, negedge rst) begin

	if(~rst)begin
		jr_out = 0;
		jr_addr = 0;
		tag = 0;
	end
	
	else begin
		jr_out = 0;
		if(jr_in && alloc) begin
		tag = tag_jr;
		end

		if (alu_res_tag == tag && tag != 0) begin
			jr_addr = value[9:0];
			jr_out = 1;
			tag = 0;
		end
		if (alu_res_tag2 == tag && tag != 0) begin
			jr_addr = value2[9:0];
			jr_out = 1;
			tag = 0;
		end
		if (ld_dest == tag && tag != 0) begin
			jr_addr = ld_value[9:0];
			jr_out = 1;
			tag = 0;
		end
		if (ld_dest2 == tag && tag != 0) begin
			jr_addr = ld_value2[9:0];
			jr_out = 1;
			tag = 0;
		end
		
		
	end


end






endmodule