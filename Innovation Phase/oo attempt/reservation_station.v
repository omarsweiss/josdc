module reservation_station (
    input clk, rst, val1_r, val2_r, write,
    input [4:0] rs_tag, rt_tag, dest_tag, alu_res_tag, alu_res_tag2,
    input [8:0] control, 
    input [31:0] val1, val2, alu_res, alu_res2,
    output reg [31:0] op1, op2, op1_2, op2_2, 
    output reg [4:0] dest_out, dest_out2,
    output reg [8:0] control_out1, control_out2,
    output reg write_rob, write_rob2,
    output wire full
);

    reg [4:0] rs [3:0];
    reg [4:0] rt [3:0];
    reg [4:0] dest [3:0];
    reg [8:0] ops [3:0];
    reg [31:0] values1 [3:0];
    reg [31:0] values2 [3:0];
    reg [3:0] busy;
    reg [1:0] ready [3:0];
    reg [1:0] pointer;
    reg slot_found, disp_found, disp_found2;
    assign full = &busy;  // Checks if all 4 entries are busy

    always @(posedge clk or negedge rst) begin : name
        integer i, j, k, w;
        
        slot_found = 1'b0;
        if (~rst) begin
            pointer = 0;
            for (i = 0; i < 4; i = i + 1) begin
                rs[i] = 0;
                rt[i] = 0;
                dest[i] = 0;
                values1[i] = 0;
                values2[i] = 0;
                ready[i] = 0;
                busy[i] = 0;
                ops[i] = 0;
            end
            control_out1 = 0;
            control_out2 = 0;
            write_rob = 0;
            write_rob2 = 0;
        end 
        else begin
            // Reset write flags each cycle
            write_rob = 0;
            write_rob2 = 0;

            // Dispatch Logic: Issue up to 2 ready instructions per cycle
            disp_found = 0;
            disp_found2 = 0;
				// Issue logic: Find an available slot and store instruction
            if (write) begin
                for (j = 0; j < 4; j = j + 1) begin
                    if (~busy[j] && ~slot_found) begin
                        ops[j] = control;
                        dest[j] = dest_tag;
                        
                        if (val1_r) begin
                            values1[j] = val1;
                            ready[j][0] = 1;
                        end else begin
                            rs[j] = rs_tag;
                        end
                        
                        if (val2_r) begin
                            values2[j] = val2;
                            ready[j][1] = 1;
                        end else begin
                            rt[j] = rt_tag;
                        end
                        
                        busy[j] = 1;
                        slot_found = 1'b1;
                    end
                end
            end
            for (w = 0; w < 4; w = w + 1) begin
                if (ready[(pointer + w) % 4] == 2'b11 && ~disp_found) begin
                    dest_out = dest[(pointer + w) % 4];
                    op1 = values1[(pointer + w) % 4];
                    op2 = values2[(pointer + w) % 4];
                    control_out1 = ops[(pointer + w) % 4];
                    write_rob = 1;
                    ready[(pointer + w) % 4] = 0;
                    busy[(pointer + w) % 4] = 0;
                    disp_found = 1;
                end 
                else if (ready[(pointer + w) % 4] == 2'b11 && ~disp_found2) begin
                    dest_out2 = dest[(pointer + w) % 4];
                    op1_2 = values1[(pointer + w) % 4];
                    op2_2 = values2[(pointer + w) % 4];
                    control_out2 = ops[(pointer + w) % 4];
                    write_rob2 = 1;
                    ready[(pointer + w) % 4] = 0;
                    busy[(pointer + w) % 4] = 0;
                    disp_found2 = 1;
                end
            end
				pointer = (pointer + 1)%4;
            if (~disp_found) begin
                dest_out = 0;
                op1 = 0;
                op2 = 0;
                control_out1 = 0;
                write_rob = 0;
            end
            if (~disp_found2) begin
                dest_out2 = 0;
                op1_2 = 0;
                op2_2 = 0;
                control_out2 = 0;
                write_rob2 = 0;
            end
				// Broadcast logic: Check if an ALU result is available for any pending instruction
            for (k = 0; k < 4; k = k + 1) begin
                if (busy[k]) begin
                    if (alu_res_tag == rs[k] && ~ready[k][0]) begin
                        values1[k] = alu_res;
                        ready[k][0] = 1;
                    end
                    if (alu_res_tag == rt[k]&& ~ready[k][1]) begin
                        values2[k] = alu_res;
                        ready[k][1] = 1;
                    end
                    if (alu_res_tag2 == rs[k]&& ~ready[k][0]) begin
                        values1[k] = alu_res2;
                        ready[k][0] = 1;
                    end
                    if (alu_res_tag2 == rt[k]&& ~ready[k][1]) begin
                        values2[k] = alu_res2;
                        ready[k][1] = 1;
                    end
                end

            

            
            end
        end
    end
endmodule
