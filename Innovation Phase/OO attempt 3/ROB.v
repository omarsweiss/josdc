module ROB(

input clk, rst, stall, alu_res_en, alu_res_en2, ld_r, ld_r2, sw_r, sw_r2, branch_r, prediction, branch_result, nop, one_instr,
input [4:0] alu_dest, alu_dest2, ld_dest,ld_dest2, sw_tag, sw_tag2, branch_tag, alu_tag, alu_tag2, ld_tag,ld_tag2, ghr_BR, read_tag1, read_tag2, read_tag1_2, read_tag2_2,
input [7:0] next_addr_BR,
input [7:0] b_addr_BR,
input [31:0] alu_val, alu_val2, ld_val,ld_val2,

output commit, commit2, commit_sw, commit_sw2, update_signal_C1, update_signal_C2, prediction_C1, prediction_C2, actual_outcome_C1, actual_outcome_C2,
output [4:0] commit_addr, commit_addr2, ghr_C1, ghr_C2,
output [7:0] next_addr_C1, next_addr_C2,
output [7:0] b_addr_C1, b_addr_C2,
output [31:0] commit_data, commit_data2,
output [31:0] read_rob1, read_rob2, read_rob1_2, read_rob2_2,
output reg [4:0] commit_p, disp_p,
output full

);



reg ready [31:0];
reg sw [31:0];
reg [4:0] dest_regs[31:0];
reg [31:0] data [31:0];

assign full = ((disp_p + 5'd2) == commit_p) | ((disp_p + 5'b1) == commit_p);



//first commit
assign commit = ready[commit_p] && ~sw[commit_p];
assign commit_sw = sw[commit_p];
assign commit_addr = dest_regs[commit_p];
assign commit_data = data[commit_p];

//second commit
assign commit2 = ready[commit_p + 5'd1] && ~sw[commit_p + 5'd1];
assign commit_sw2 = sw[commit_p + 5'd1];
assign commit_addr2 = dest_regs[commit_p + 5'd1];
assign commit_data2 = data[commit_p + 5'd1];



//read_rob

assign read_rob1 = data [read_tag1];
assign read_rob2 = data [read_tag2];
assign read_rob1_2 = data [read_tag1_2];
assign read_rob2_2 = data [read_tag2_2];





always @(posedge clk, negedge rst) begin: name
	integer i;
	if(~rst) begin 
		for (i = 0; i <32; i = i + 1) begin
			ready[i] <= 0;
			sw[i] <= 0;
			dest_regs[i] <= 0;
			data[i] <= 0;
		end
		disp_p <= 0;
		commit_p <= 0; 
	end
	else begin
		
		
		//write values when ready
		if (alu_res_en) begin
			ready[alu_tag] <= 1'b1;
			sw[alu_tag] <= 1'b0;
			dest_regs[alu_tag] <= alu_dest;
			data[alu_tag] <= alu_val;
		end
		if (alu_res_en2) begin
			ready[alu_tag2] <= 1'b1;
			sw[alu_tag2] <= 1'b0;
			dest_regs[alu_tag2] <= alu_dest2;
			data[alu_tag2] <= alu_val2;
		end
		if (ld_r) begin
			ready[ld_tag] <= 1'b1;
			sw[ld_tag] <= 1'b0;
			dest_regs[ld_tag] <= ld_dest;
			data[ld_tag] <= ld_val;
		end
		if (ld_r2) begin
			ready[ld_tag2] <= 1'b1;
			sw[ld_tag2] <= 1'b0;
			dest_regs[ld_tag2] <= ld_dest2;
			data[ld_tag2] <= ld_val2;
		end
		if (sw_r) begin
			sw[sw_tag] <= 1'b1;
			ready[sw_tag] <= 1'b1;
		end
		if (sw_r2) begin
			sw[sw_tag2] <= 1'b1;
			ready[sw_tag2] <= 1'b1;
		end
		
		
		// increment commit pointer
		if(ready[commit_p] == 1'b1) begin 
			if (ready[commit_p + 1] == 1'b1) commit_p <= commit_p + 5'd2;
			else commit_p <= commit_p + 5'd1;
		end
			
		
		if (~stall && one_instr) begin //issue one instr
			disp_p <= disp_p + 5'd1;
			ready[disp_p] <= 0;
			sw[disp_p] <= 0;
			dest_regs[disp_p] <= 0;
			data[disp_p] <= 0;
		
		end
		else if (~stall && ~one_instr) begin //issue two instr
			disp_p <= disp_p + 5'd2;
			ready[disp_p] <= 0;
			sw[disp_p] <= 0;
			dest_regs[disp_p] <= 0;
			data[disp_p] <= 0;
			
			
			ready[disp_p + 5'b1] <= 0;
			sw[disp_p + 5'b1] <= 0;
			dest_regs[disp_p + 5'b1] <= 0;
			data[disp_p + 5'b1] <= 0;
			
		end
	
		
	end



end

endmodule
