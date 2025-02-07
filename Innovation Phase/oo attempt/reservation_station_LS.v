module reservation_station_LS(
	 input clk, rst, data_r, reg_r, write, mem_write, commit_sw1, commit_sw2, alu_w_r, alu_w_r2, ld_write, ld_write2,
    input [4:0] rs_tag, rt_tag, alu_res_tag, alu_res_tag2, ld_tag,ld_tag2, sw_tag_in,
    input [31:0] val1, val2,imm, alu_res, alu_res2, ld_res, ld_res2,
    output reg [31:0] address_out, data_out, address_out2, data_out2,
    output reg [4:0] dest_out, dest_out2, sw_tag_out, sw_tag_out2,
    output reg mem_write_out,mem_write_out2, disp1, disp2,
    output wire full
);


		
	 reg [4:0] addr_tag [7:0];
    reg [4:0] data_tag [7:0];
    reg [7:0] sw;
    reg [31:0] immediate [7:0];
    reg [31:0] data [7:0];
	 reg [31:0] reg_addr [7:0];
    reg [7:0] busy;
    reg [1:0] ready [7:0];
    reg [2:0] issue_p,disp_p;
    reg [4:0] sw_tags [7:0];
	 
    assign full = &busy;  // Checks if all 8 entries are busy

	
	 always @(posedge clk or negedge rst) begin : name
	  integer i, j, k, w;
	  
	  
	  if (~rst) begin
		
			mem_write_out = 0;
			mem_write_out2 = 0;
			disp1 = 0;
			disp2 = 0;
			issue_p = 0;
			disp_p = 0;
			dest_out = 0;
			address_out = 0;
			data_out = 0;
			
			dest_out2 = 0;
			address_out2 = 0;
			data_out2 = 0;
			sw_tag_out = 0;
			sw_tag_out2 = 0;
			for (i = 0; i < 8; i = i + 1) begin
				 addr_tag[i] = 0;
				 data_tag[i] = 0;
				 sw[i] = 0;
				 sw_tags[i] = 0;
				 immediate[i] = 0;
				 data[i] = 0;
				 reg_addr[i] = 0;
				 ready[i] = 0;
				 busy[i] = 0;
				 
			end
	  end 
	  else begin
			mem_write_out = 0;
			mem_write_out2 = 0;
			disp1 = 0;
			disp2 = 0;
			dest_out = 0;
			address_out = 0;
			data_out = 0;
			sw_tag_out = 0;
			sw_tag_out2 = 0;
			// Dispatch Logic: Issue up to 2 ready instructions per cycle
			// Issue logic: enqueue
			if (write) begin
				 sw[issue_p] = mem_write;
				 immediate[issue_p] = imm;
				 data_tag[issue_p] = rt_tag;
				 busy[issue_p] = 1'b1;
				 sw_tags[issue_p] = sw_tag_in;
				 if(mem_write && data_r)begin
					data[issue_p] = val2;
					ready[issue_p][1] = 1'b1;
				 end
				 if(reg_r)begin
					reg_addr[issue_p] = val1;
					ready[issue_p][0] = 1'b1;
				 end
				 else addr_tag[issue_p] = rs_tag;
				 issue_p = issue_p + 3'd1;
			end
			// Broadcast logic: Check if an ALU result is available for any pending instruction
			for (k = 0; k < 8; k = k + 1) begin
				 if (busy[k]) begin
					  if (alu_res_tag == addr_tag[k] && ~ready[k][0] && alu_w_r) begin
							reg_addr[k] = alu_res;
							ready[k][0] = 1;
					  end
					  if (alu_res_tag == data_tag[k]&& ~ready[k][1] && sw[k] && alu_w_r) begin
							data[k] = alu_res;
							ready[k][1] = 1;
					  end
					  if (alu_res_tag2 == addr_tag[k]&& ~ready[k][0] && alu_w_r2) begin
							reg_addr[k] = alu_res2;
							ready[k][0] = 1;
					  end
					  if (alu_res_tag2 == data_tag[k]&& ~ready[k][1] && sw[k] && alu_w_r2) begin
							data[k] = alu_res2;
							ready[k][1] = 1;
					  end
					  if (ld_tag == addr_tag[k]&& ~ready[k][0] && ld_write) begin
							reg_addr[k] = ld_res;
							ready[k][0] = 1;
					  end
					  if (ld_tag == data_tag[k]&& ~ready[k][1] && sw[k] && ld_write) begin
							data[k] = ld_res;
							ready[k][1] = 1;
					  end
					  if (ld_tag2 == addr_tag[k]&& ~ready[k][0] && ld_write2) begin
							reg_addr[k] = ld_res2;
							ready[k][0] = 1;
					  end
					  if (ld_tag2 == data_tag[k]&& ~ready[k][1] && sw[k] && ld_write2) begin
							data[k] = ld_res2;
							ready[k][1] = 1;
					  end
				 end
			end
			
			
			if(~commit_sw2 && busy[disp_p] && ready[disp_p][0] && (~sw[disp_p] || ready[disp_p][1])) begin
				disp1 = 1'b1;
				mem_write_out = sw [disp_p];
				address_out = immediate[disp_p] + reg_addr[disp_p];
				data_out = data[disp_p];
				dest_out = data_tag[disp_p];
				busy[disp_p] = 0;
				ready[disp_p] = 0;
				sw_tag_out = sw_tags[disp_p];
				if ((~commit_sw1 && busy[(disp_p + 1)%8] && ready[(disp_p + 1)%8][0] && (~sw[(disp_p + 1)%8] || ready[(disp_p + 1)%8][1])) && ~((immediate[disp_p] + reg_addr[disp_p]) == (immediate[(disp_p + 1)%8] + reg_addr[(disp_p + 1)%8]))) begin
					disp2 = 1'b1;
					mem_write_out2 = sw [(disp_p + 1)%8];
					address_out2 = immediate[(disp_p + 1)%8] + reg_addr[(disp_p + 1)%8];
					data_out2 = data[(disp_p + 1)%8];
					dest_out2 = data_tag[(disp_p + 1)%8];
					busy[(disp_p + 1)%8] = 0;
					ready[(disp_p + 1)%8] = 0;
					disp_p = disp_p + 3'd2;
					sw_tag_out2 = sw_tags[(disp_p + 1)%8];
				end
				else disp_p = disp_p + 3'd1;
				
			end
			
			
		end
	end
	
	

endmodule