module ROB #(
    parameter QUEUE_SIZE = 32   // Number of instructions the queue can hold
) 
(
    input clk, rst, issue, write, write2, ld_write, ld_write2, SW_in, sw_disp, sw_disp2, jal,
    input [4:0] dest_reg, val_idx, val_idx2, ld_dest, ld_dest2, sw_disp_tag, sw_disp_tag2,
    input [9:0] jal_address,
    input [31:0] value, value2, ld_value, ld_value2,
    output wire [4:0] commit_addr, commit_addr2,
    output wire [31:0] commit_val, commit_val2,
    output wire commit1, commit2, commit_SW, commit_SW2,
    output wire [4:0] tag,
    output wire full, write_rat
);

    reg [4:0] dest_regs [31:0];
    reg [31:0] values [31:0];
    reg [31:0] ready;
    reg [31:0] store;
    reg [4:0] issue_p, commit_p;

    assign full = (commit_p == (issue_p + 1) % QUEUE_SIZE);
    assign tag = issue_p;
    assign write_rat = (~full && issue) ? 1'b1 : 1'b0;
	assign commit_addr = dest_regs[commit_p];
	assign commit_val = values[commit_p];
	assign commit_SW = store[commit_p];
	assign commit1 = ~commit_SW & ready[commit_p];
	assign commit_addr2 = dest_regs[(commit_p + 1) % QUEUE_SIZE];
	assign commit_val2 = values[(commit_p + 1) % QUEUE_SIZE];
	assign commit_SW2 = store[(commit_p + 1) % QUEUE_SIZE];
	assign commit2 = ~commit_SW2 & ready[(commit_p + 1) % QUEUE_SIZE];
    always @(posedge clk or negedge rst) begin : name
        integer i;
        if (~rst) begin
            ready <= 0;
            issue_p <= 0;
            commit_p <= 0;
            store <= 0;

            for (i = 0; i < 32; i = i + 1) begin
                dest_regs[i] <= 0;
                values[i] <= 0;
            end
        end else begin
            // Write on the ROB when an instruction is issued.
            if (~full && issue) begin 
                if (jal) begin
                    dest_regs[issue_p] <= 5'b11111;
                    ready[issue_p] <= 1;
                    values[issue_p] <= {22'b0, jal_address};
                    store[issue_p] <= SW_in;
                end else begin
                    dest_regs[issue_p] <= dest_reg;
                    ready[issue_p] <= 0;
                    store[issue_p] <= SW_in;
                end
                issue_p <= (issue_p + 1) % QUEUE_SIZE;
            end

            // From the common data bus
            if (write) begin
                values[val_idx] <= value;
                ready[val_idx] <= 1;
            end
            if (write2) begin
                values[val_idx2] <= value2;
                ready[val_idx2] <= 1;
            end
            if (ld_write) begin
                values[ld_dest] <= ld_value;
                ready[ld_dest] <= 1;
            end
            if (ld_write2) begin
                values[ld_dest2] <= ld_value2;
                ready[ld_dest2] <= 1;
            end
            if (sw_disp) begin
                ready[sw_disp_tag] <= 1;
            end
            if (sw_disp2) begin
                ready[sw_disp_tag2] <= 1;
            end

            // When a commit is possible
            if (ready[commit_p] == 1) begin
                if (ready[(commit_p + 1) % QUEUE_SIZE] == 1) begin
                    commit_p <= (commit_p + 2) % QUEUE_SIZE;
                end else begin
                    commit_p <= (commit_p + 1) % QUEUE_SIZE;
                end
            end 
        end
    end

endmodule