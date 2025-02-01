module InstructionQueue #(
    parameter QUEUE_SIZE = 4'd8,   // Number of instructions the queue can hold
    parameter INSTR_WIDTH = 32  // Instruction bit width
)(
    input wire clk,             // Clock signal
    input wire reset,           // Reset signal
    input wire enqueue,         // Signal to enqueue an instruction
    input wire [INSTR_WIDTH-1:0] instr_in, // Incoming instruction
    input wire stall,           // Stall signal from RS (prevents issuing)
    output reg [INSTR_WIDTH-1:0] instr_out, // Instruction to issue
    output reg full,             // Queue full flag
    output reg write,				//Flag to enable writing on the RS
	 output reg empty             // Queue empty flag
);

    // Instruction storage and valid bits
    reg [INSTR_WIDTH-1:0] queue [0:QUEUE_SIZE-1];
    reg valid [0:QUEUE_SIZE-1]; // Valid bit for each entry

    // Head and tail pointers for circular buffer
    reg [3:0] head, tail;
    // Update full/empty flags
	 always @(*) begin : name2
		full = (head == (tail + 1) % QUEUE_SIZE);
		empty = (head == tail);
	end
    always @(posedge clk or negedge reset) begin : name
		integer i;
        if (~reset) begin
            head <= 0;
            tail <= 0;
            instr_out <= 0;
            for (i = 0; i < QUEUE_SIZE; i = i + 1) begin
                queue[i] <= 0;
                valid[i] <= 0;
            end
        end else begin
            // Enqueue logic (only if not full)
            if (enqueue && !full&&~valid[tail]) begin
                queue[tail] <= instr_in;
                valid[tail] <= 1'b1;
                tail <= (tail + 4'd1) % QUEUE_SIZE;
            end
            // Issue logic (only if not stalled)
            if (!empty && !stall&&valid[head] ) begin
                instr_out <= queue[head];
					 write = 1'b1;
					 valid[head] <= 0;
                head <= (head + 4'd1) % QUEUE_SIZE;
            end
				else begin
					instr_out = 0;
					write = 1'b0;
				end
        end
    end

endmodule
