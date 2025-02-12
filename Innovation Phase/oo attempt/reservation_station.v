module reservation_station (
    input clk, rst, val1_r, val2_r, write, alu_w_r, alu_w_r2, ld_write, ld_write2,
    input [4:0] rs_tag, rt_tag, dest_tag, alu_res_tag, alu_res_tag2, ld_tag, ld_tag2,
    input [8:0] control, 
    input [31:0] val1, val2, alu_res, alu_res2, ld_value, ld_value2,
    output wire [31:0] op1, op2, op1_2, op2_2, 
    output wire [4:0] dest_out, dest_out2,
    output wire [8:0] control_out1, control_out2,
    output wire write_rob, write_rob2,
    output wire full
);

      // Reservation station storage (4 entries)
  reg [4:0] rs [3:0];
  reg [4:0] rt [3:0];
  reg [4:0] dest [3:0];
  reg [8:0] ops [3:0];
  reg [31:0] values1 [3:0];
  reg [31:0] values2 [3:0];
  reg [3:0] busy;
  // Each entry has 2 bits indicating operand readiness: [operand1, operand2]
  reg [1:0] ready [3:0];
  // To input only one entry
  reg slot_found;
  // Compute the full flag (all slots busy)
  assign full = &busy;

  // Create a 4-bit ready vector. A slot is ready for dispatch if both operands are ready.
  wire [3:0] ready_vector;
  assign ready_vector[0] = (ready[0] == 2'b11);
  assign ready_vector[1] = (ready[1] == 2'b11);
  assign ready_vector[2] = (ready[2] == 2'b11);
  assign ready_vector[3] = (ready[3] == 2'b11);

  // First dispatch: use a priority encoder to select the first ready slot.
  wire [1:0] slot1;
  wire valid1;
  priority_encoder #(4) pe1 (
      .in(ready_vector),
      .index(slot1),
      .valid(valid1)
  );

  // Mask out the first selected slot for the second encoder.
  wire [3:0] mask;
  assign mask = 4'b0001 << slot1; // one-hot mask for the first slot
  wire [3:0] ready_vector_masked = ready_vector & ~mask;

  // Second dispatch: select the next ready slot.
  wire [1:0] slot2;
  wire valid2;
  priority_encoder #(4) pe2 (
      .in(ready_vector_masked),
      .index(slot2),
      .valid(valid2)
  );

  // Multiplexers for dispatch outputs (combinational logic)
  // Here we assume that a multiplexer based on slot index selects the corresponding
  // values from the internal arrays.
  assign op1          = values1[slot1];
  assign op2          = values2[slot1];
  assign dest_out     = dest[slot1];
  assign control_out1 = ops[slot1];
  assign write_rob    = valid1; // Asserted if a valid slot is found

  assign op1_2          = valid2 ? values1[slot2] : 32'b0;
  assign op2_2          = valid2 ? values2[slot2] : 32'b0;
  assign dest_out2      = valid2 ? dest[slot2]    : 5'b0;
  assign control_out2   = valid2 ? ops[slot2]     : 9'b0;
  assign write_rob2     = valid2;
    always @(posedge clk or negedge rst) begin : name
        integer i, j, k, w;
        

        if (~rst) begin
            for (i = 0; i < 4; i = i + 1) begin
                rs[i] <= 0;
                rt[i] <= 0;
                dest[i] <= 0;
                values1[i] <= 0;
                values2[i] <= 0;
                ready[i] <= 0;
                busy[i] <= 0;
                ops[i] <= 0;
            end
        end else begin
            slot_found =0;
            if (write) begin
                for (j = 0; j < 4; j = j + 1) begin
                    if (~busy[j] && ~slot_found) begin
                        ops[j] = control;
                        dest[j] = dest_tag;
                        busy[j] = 1;
                        if (val1_r) begin
                            values1[j] = val1;
                            ready[j][0] = 1;
                        end else begin
                            rs[j] = rs_tag;
                            ready[j][0] = 0;
                        end
                        if (val2_r) begin
                            values2[j] = val2;
                            ready[j][1] = 1;
                        end else begin
                            rt[j] = rt_tag;
                            ready[j][1] = 0;
                        end
                        slot_found = 1'b1;
                    end
                end
            end
            for (k = 0; k < 4; k = k + 1) begin
                if (busy[k]) begin
                    if (alu_res_tag == rs[k] && ~ready[k][0] && alu_w_r)
                        values1[k] = alu_res;
                         ready[k][0] = 1;
                    if (alu_res_tag == rt[k] && ~ready[k][1] && alu_w_r)
                        values2[k] = alu_res;
                         ready[k][1] = 1;
                    if (alu_res_tag2 == rs[k] && ~ready[k][0] && alu_w_r2)
                        values1[k] = alu_res2;
                         ready[k][0] = 1;
                    if (alu_res_tag2 == rt[k] && ~ready[k][1] && alu_w_r2)
                        values2[k] = alu_res2;
                         ready[k][1] = 1;
                    if (ld_tag == rs[k] && ~ready[k][0] && ld_write)
                        values1[k] = ld_value;
                         ready[k][0] = 1;
                    if (ld_tag == rt[k] && ~ready[k][1] && ld_write)
                        values2[k] = ld_value;
                         ready[k][1] = 1;
                    if (ld_tag2 == rs[k] && ~ready[k][0] && ld_write2)
                        values1[k] = ld_value2;
                         ready[k][0] = 1;
                    if (ld_tag2 == rt[k] && ~ready[k][1] && ld_write2)
                        values2[k] = ld_value2;
                         ready[k][1] = 1;
                end
            end
            busy[slot1] = write_rob ?0: busy[slot1];
            busy[slot2] = write_rob2 ?0: busy[slot2];
        end
    end
endmodule