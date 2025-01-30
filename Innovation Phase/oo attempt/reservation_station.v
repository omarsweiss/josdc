module reservation_station (
input clk, rst, val1_r, val2_r, write,
input [4:0] rs_tag, rt_tag, dest_tag, alu_res_tag,
input [5:0] control, 
input [31:0] val1, val2, alu_res,
output reg [31:0] op1, op2, op1_2, op2_2, 
output reg [4:0] dest_out, dest_out2,
output reg full
);

reg [4:0] rs [3:0];
reg [4:0] rt [3:0];
reg [4:0] dest [3:0];
reg [5:0] ops [4:0];
reg [31:0] values1 [3:0];
reg [31:0] values2 [3:0];
reg [3:0] busy;
reg [1:0] ready [3:0];
reg [1:0] pointer;
reg slot_found, disp_found, disp_found2;
assign full = busy[0]&busy[1]&busy[2]&busy[3];

always @(posedge clk, negedge rst) begin
	integer i,j,k,w;
	slot_found = 0;
	disp_found = 0;
	disp_found2 = 0;
	
	if(~rst) begin
		pointer = 0;
		for(i=0; i<4; i = i + 1) begin
		rs[i] = 0;
		rt[i] = 0;
		dest[i] = 0;
		values1[i] = 0;
		values2[i] = 0;
		ready[i] = 0;
		busy[i] = 0;
		ops[i] = 0;
		end
	end
	else begin
		if (write) begin 
			for (j = 0; j < 4; j = j + 1) begin //issue in reservation
				if (~busy[j]&& ~slot_found) begin
						ops[j] = control;
						dest[j] = dest_tag;
						if (val1_r) begin
							values1[j] = val1;
							ready[j][0] = 1'b1;
						end
						
						else 
							rs[j] = rs_tag;
                
						if (val2_r) begin
							values2[j] = val2;
							ready[j][1] = 1'b1;
						end
						
						else 
							rt[j] = rt_tag;

						busy[j] = 1'b1;
						
            // Exit loop once a free slot is found and used
						slot_found = 1'b1;
				end
			end
			for (k = 0; k < 4; k = k + 1) begin //broadcast values (from ALU)
				if(busy[k]) begin 
					if (alu_res_tag == rs[k]) begin
						values1[k] = alu_res;
						ready[k][0] = 1'b1;
					end
					if (alu_res_tag == rt[k]) begin
						values2[k] = alu_res;
						ready[k][1] = 1'b1;
					end
				
				end
			end
		end
		for (w = 0; w < 4; w = w + 1) //dispatch
			if(ready[pointer + w] == 2'b11 && ~disp_found) begin
				dest_out = dest[pointer + w];
				op1 = values1 [pointer + w];
				op2 = values2 [pointer + w];
				ready[pointer + w] = 2'b00;
				busy[pointer + w] = 1'b0;
				pointer = pointer + 1'b1;
				disp_found = 1'b1;
			end
			else if(ready[pointer + w] == 2'b11 && ~disp_found2) begin
				dest_out2 = dest[pointer + w];
				op1_2 = values1 [pointer + w];
				op2_2 = values2 [pointer + w];
				ready[pointer + w] = 2'b00;
				busy[pointer + w] = 1'b0;
				pointer = pointer + 1'b1;
				disp_found2 = 1'b1;
			
			end
			
		
		
	end
end














endmodule