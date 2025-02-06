module ROB #(
    parameter QUEUE_SIZE = 32   // Number of instructions the queue can hold
) 
(
input clk,rst,issue, write, write2,
input [4:0] dest_reg, val_idx, val_idx2,
input [31:0] value, value2,
output reg [4:0] tag,
output reg [4:0] commit_addr, commit_addr2,
output reg [31:0] commit_val, commit_val2,
output reg full,
output reg commit1, commit2, write_rat//Set when commiting to write on the RF
);

reg [4:0] dest_regs [31:0];
reg [31:0] values [31:0];
reg [31:0] ready;
reg [4:0] issue_p, commit_p;
always @(*) begin : name2
		full = (commit_p == (issue_p + 1) % QUEUE_SIZE);
		tag = issue_p;
		if(~full && issue) write_rat = 1'b1; //Write on RAT
		else write_rat=0;
end
always @(posedge clk, negedge rst) begin : name
	integer i;
	
	if (~rst) begin
		ready = 0;
		issue_p=0;
		commit_p=0;
		for(i=0; i<32; i = i + 1) begin
			dest_regs[i] = 0;
			values[i] = 0;
		end
	end
	else begin
		//Write on the ROB when an instruction is issued.
		if(~full&&issue) begin 
			dest_regs[issue_p] = dest_reg;
			ready[issue_p] = 0;

			issue_p = (issue_p + 5'b1)%32;
		end
		//From the common data bus
		if (write) begin
			values[val_idx] = value;
			ready[val_idx] = 1;
		end
		if (write2) begin
			values[val_idx2] = value2;
			ready[val_idx2] = 1;
		end
		//When a commit is possible. can make double commit by adding a for loop that checks twice.
		if (ready[commit_p] == 1) begin
			commit_addr = dest_regs[commit_p];
			commit_val = values [commit_p];
			commit1 = 1'b1;
			ready[commit_p] = 1'b0;
			if (ready[(commit_p + 5'd1)%32] == 1) begin
				commit_addr2 = dest_regs[(commit_p + 5'd1)%32];
				commit_val2 = values [(commit_p + 5'd1)%32];
				commit_p = (commit_p +5'd2)%32;
				commit2 = 1'b1;
				ready[(commit_p + 5'd1)%32] = 1'b0; 
			end
			else commit_p = (commit_p + 5'd1)%32;
		end
	end
end
endmodule