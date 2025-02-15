module branch_control(input clk,rst,
input Branch1_t, Branch2_t,Branch1_n, Branch2_n,Branch1_t_ID, Branch2_t_ID,Branch1_n_ID, Branch2_n_ID,
taken1_t, taken2_t,taken1_n, taken2_n,

input [9:0] nextPC_n, nextPC_t, BTA1_n_ID, BTA2_n_ID, nextPC_ID_n, nextPC_ID_t,

output reg flush_IFID_t, flush_IDEX_t, correct_en_t, flush_IFID_n, flush_IDEX_n, 
 correct_en_n, pipe_valid,
 
output reg [9:0] correction_n, correction_t
);

always @(posedge clk, negedge rst)begin
	if (~rst) pipe_valid <= 1'b1;
	else begin
		if (((Branch1_t || Branch2_t) && (taken1_t || taken2_t)) || ((Branch1_n || Branch2_n) && (taken1_n || taken2_n))) begin
			pipe_valid <= 1'b1;
		end
		if (((Branch1_t || Branch2_t) && ~(taken1_t || taken2_t)) || ((Branch1_n || Branch2_n) && ~(taken1_n || taken2_n))) begin
			pipe_valid <= 1'b0;
		end
	end
end 


always @(*) begin
	if(~rst) begin 
		flush_IFID_t = 0;
		flush_IDEX_t = 0;
		flush_IFID_n = 0;
		flush_IDEX_n = 0;
		correct_en_t = 0;
		correct_en_n = 0;
		correction_n = 0;
		correction_t = 0;
	end
	else begin
	   if(((Branch1_t_ID || Branch2_t_ID) && (Branch1_t || Branch2_t)) || ((Branch1_n_ID || Branch2_n_ID) && (Branch1_n || Branch2_n))
			&& ~(nextPC_ID_t == nextPC_ID_n))begin
			
			if(((Branch1_t || Branch2_t) && (taken1_t || taken2_t)) || ((Branch1_n || Branch2_n) && (taken1_n || taken2_n))) begin
				correct_en_n = 1'b1;
				correction_n = nextPC_ID_t;
				flush_IFID_n = 1'b1;
				flush_IDEX_n = 1'b1;
				correct_en_t = 1'b0;
				correction_t = 10'b0;
				flush_IFID_t = 1'b0;
				flush_IDEX_t = 1'b0;
			end
			else begin
				correct_en_t = 1'b1;
				correction_t = Branch1_n_ID? BTA1_n_ID: BTA2_n_ID;
				flush_IFID_t = 1'b1;
				flush_IDEX_t = 1'b1;
				correct_en_n = 1'b0;
				correction_n = 10'b0;
				flush_IFID_n = 1'b0;
				flush_IDEX_n = 1'b0;
			end
			
		end
		else if ((Branch1_t || Branch2_t || Branch1_n || Branch2_n)) begin
			if (taken1_t || taken2_t || taken1_n || taken2_n) begin
				correct_en_n = 1'b1;
				correction_n = nextPC_t;
				flush_IFID_n = 1'b1;
				flush_IDEX_n = 1'b1;
				correct_en_t = 1'b0;
				correction_t = 10'b0;
				flush_IFID_t = 1'b0;
				flush_IDEX_t = 1'b0;
				
			end
			else begin
				correct_en_t = 1'b1;
				correction_t = nextPC_n;
				flush_IFID_t = 1'b1;
				flush_IDEX_t = 1'b1;
				correct_en_n = 1'b0;
				correction_n = 10'b0;
				flush_IFID_n = 1'b0;
				flush_IDEX_n = 1'b0;
			end
			
		end 
		else begin 
			correct_en_t = 1'b0;
			correction_t = 10'b0;
			flush_IFID_t = 1'b0;
			flush_IDEX_t = 1'b0;
			correct_en_n = 1'b0;
			correction_n = 10'b0;
			flush_IFID_n = 1'b0;
			flush_IDEX_n = 1'b0;
		end
		
	
	end

end





/*
case 1: one branch in each dual issue: 
logic is:
 do the two pipes have a branch with the same pc? if so pick the correct pipe (t or not t)
if T: update nt with nextpc of tpipe
if NT: update t with nextpc of ntpipe
*note:nextPCOut of T pipe does not include BTA and nextPcOut  of NT pipe includes BTA to account for BIB hazards

case 2: two subsequent branches
logic: two pipes have the same branch with same pc and is the decode instruction also a branch? if
EX Branch is T: Update NT with fall through path of decode branch
EX Branch is NT: Update T with with BTA of decode branch

case 3: bib
same as case 1 



case1 : incorrect pipe flush F D.
*/


endmodule