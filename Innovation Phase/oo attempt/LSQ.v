module store_buffer(
  input clk, rst, disp1, disp2, sw_in1,sw_in2, commit, commit2,
  input [31:0] address_in, data_in,address_in2, data_in2,
  
  output full,
  output reg sw_out,sw_out2,ld_out,ld_out2 ld_found2, ld_found,
  
  output reg [31:0] address_out, data_out,address_out2, data_out2
);

  
  
  
  
  reg [31:0] address [0:7];
  reg [31:0] data [0:7];
  reg busy [0:7];
  reg [2:0] disp_p, commit_p;

  
  


  

  // Full signal
  assign full = (commit_p == (disp_p + 1) % 8);

  always @(posedge clk or negedge rst) begin
    integer k,w,x;
    if (!rst) begin
      disp_p <= 0;
      commit_p <= 0;
      for (k = 0; k < 8; k = k + 1) begin
        busy[i] <= 0;
        address[k] <= 0;
        data[k] <= 0;
      end
      sw_out <= 0;
      sw_out2 <= 0;
		ld_out <= 0;
      ld_out2 <= 0;
      ld_found <= 0;
      ld_found2 <= 0;
      address_out <= 0;
      data_out <= 0;
		address_out2 <= 0;
      data_out2 <= 0;
    end else begin
      // enqueue logic
      if (sw_in1) begin
        address[issue_p] <= address_in;
        data[issue_p] <= data_in;
		  busy[issue_p] <= 1'b1;
        if (sw_in2)begin
			address[(issue_p + 1) % 8] <= address_in;
			data[(issue_p + 1) % 8] <= data_in;
			busy[(issue_p + 1) % 8] <= 1'b1;
			issue_p <= (issue_p + 2) % 8;
			end
		  else issue_p <= (issue_p + 2) % 8;
      end

		
		
      // Dispatch logic
      if (disp1 && ~sw_in1) begin
        for (k = 0; k < 8; k = k + 1) begin
          if (address_in == address[k] && busy[k]) begin
            address_out <= address_in;
            data_out = data[k];
				ld_found = 1'b1;
				ld_out = 1'b1;
          end
        end
      end
		if (disp2 && ~sw_in2) begin
        for (k = 0; k < 8; k = k + 1) begin
          if (address_in2 == address[k] && busy[k]) begin
            address_out2 <= address_in;
            data_out2 = data[k];
				ld_found2 = 1'b1;
				ld_out2 = 1'b1;
          end
        end
      end

      // Load execution logic
    
      // Commit logic
      if (commit) begin
          sw_out <= 1'b1;
          data_out <= data[commit_p];
          address_out <= address[commit_p];
			 busy[commit_p] <=0;
		  if(commit2)begin
				sw_out <= 1'b1;
				data_out <= data[(commit_p + 1) % 8];
				address_out <= address[(commit_p + 1) % 8];
				busy[(commit_p + 1) % 8] <=0;
				commit_p <= (commit_p + 2) % 8;
		  end
        else commit_p <= (commit_p + 1) % 8;
      end
    end
  end
endmodule