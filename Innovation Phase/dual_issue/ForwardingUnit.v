module forwarding_unit(
  input [4:0] rs1_ID,
  input [4:0] rt1_ID,
  input [4:0] rs2_ID,
  input [4:0] rt2_ID,
  input [4:0] dest1_EX,
  input [4:0] dest2_EX,
  input [4:0] dest1_MEM,
  input [4:0] dest2_MEM,
  input [4:0] dest1_wb,
  input [4:0] dest2_wb,
  input [4:0] rt1_mem,
  input [4:0] rt2_mem,
  input rst,
  input regwrite1_EX,
  input regwrite2_EX,
  input regwrite1_MEM,
  input regwrite2_MEM,
  input MemWriteEn1_MEM,
  input MemWriteEn2_MEM,
  output reg [4:0] ForwardA1,
  output reg [4:0] ForwardB1,
  output reg [4:0] ForwardA2,
  output reg [4:0] ForwardB2,
  output reg [1:0] memFw1,
  output reg [1:0] memFw2

  );
  
   always @(*) begin
		if(~rst) begin
			memFw1 = 2'b0;
			memFw2 = 2'b0;
		end
		else begin
			if (dest1_wb == rt1_mem && MemWriteEn1_MEM) memFw1 = 2'b01;
			else if (dest2_wb == rt1_mem && MemWriteEn2_MEM) memFw1 = 2'b10;
			else memFw1 = 2'b0;
			
			if (dest1_wb == rt2_mem && MemWriteEn1_MEM) memFw2 = 2'b01;
			else if (dest2_wb == rt2_mem && MemWriteEn2_MEM) memFw2 = 2'b10;
			else memFw2 = 2'b0;
		end
	end
		
		wire rs1_eq_d1mem,rs1_eq_d2mem,rs1_eq_d1ex,rs1_eq_d2ex,rs2_eq_d1mem,rs2_eq_d2mem,rs2_eq_d1ex,rs2_eq_d2ex,
				rt2_eq_d1mem,rt2_eq_d2mem,rt2_eq_d1ex,rt2_eq_d2ex,rt1_eq_d1mem,rt1_eq_d2mem,rt1_eq_d1ex,rt1_eq_d2ex,
				d1mem_valid,d2mem_valid,d1ex_valid,d2ex_valid;
    // Pre-compute all equality comparisons in parallel
    assign rs1_eq_d1mem = (rs1_ID == dest1_MEM);
    assign rs1_eq_d2mem = (rs1_ID == dest2_MEM);
    assign rs1_eq_d1ex  = (rs1_ID == dest1_EX);
    assign rs1_eq_d2ex  = (rs1_ID == dest2_EX);
    
    assign rs2_eq_d1mem = (rs2_ID == dest1_MEM);
    assign rs2_eq_d2mem = (rs2_ID == dest2_MEM);
    assign rs2_eq_d1ex  = (rs2_ID == dest1_EX);
    assign rs2_eq_d2ex  = (rs2_ID == dest2_EX);
    
    assign rt1_eq_d1mem = (rt1_ID == dest1_MEM);
    assign rt1_eq_d2mem = (rt1_ID == dest2_MEM);
    assign rt1_eq_d1ex  = (rt1_ID == dest1_EX);
    assign rt1_eq_d2ex  = (rt1_ID == dest2_EX);
    
    assign rt2_eq_d1mem = (rt2_ID == dest1_MEM);
    assign rt2_eq_d2mem = (rt2_ID == dest2_MEM);
    assign rt2_eq_d1ex  = (rt2_ID == dest1_EX);
    assign rt2_eq_d2ex  = (rt2_ID == dest2_EX);

    // Pre-compute valid destinations (non-zero check)
    assign d1mem_valid = |dest1_MEM;
    assign d2mem_valid = |dest2_MEM;
    assign d1ex_valid  = |dest1_EX;
    assign d2ex_valid  = |dest2_EX;

    // Generate forwarding signals using priority encoder structure
    always @(*) begin
        // Default assignments
        {ForwardA1, ForwardA2, ForwardB1, ForwardB2} = {4{5'b00001}};
        
        if (rst) begin
            // ForwardA1 logic
            casez ({
					regwrite2_EX  & rs1_eq_d2ex  & d2ex_valid,
                regwrite1_EX  & rs1_eq_d1ex  & d1ex_valid,	
                regwrite2_MEM & rs1_eq_d2mem & d2mem_valid,
                regwrite1_MEM & rs1_eq_d1mem & d1mem_valid
                
            })
                4'b1???: ForwardA1 = 5'b01000;
                4'b01??: ForwardA1 = 5'b00010;
                4'b001?: ForwardA1 = 5'b10000;
                4'b0001: ForwardA1 = 5'b00100;
                default: ForwardA1 = 5'b00001;
            endcase

            // ForwardA2 logic
            casez ({
				regwrite2_EX  & rs2_eq_d2ex  & d2ex_valid,
                regwrite1_EX  & rs2_eq_d1ex  & d1ex_valid,
                regwrite2_MEM & rs2_eq_d2mem & d2mem_valid,
                regwrite1_MEM & rs2_eq_d1mem & d1mem_valid
                
            })
                4'b1???: ForwardA2 = 5'b01000;
                4'b01??: ForwardA2 = 5'b00010;
                4'b001?: ForwardA2 = 5'b10000;
                4'b0001: ForwardA2 = 5'b00100;
                default: ForwardA2 = 5'b00001;
            endcase

            // ForwardB1 logic
            casez ({
					regwrite2_EX  & rt1_eq_d2ex  & d2ex_valid,
                regwrite1_EX  & rt1_eq_d1ex  & d1ex_valid,
                regwrite2_MEM & rt1_eq_d2mem & d2mem_valid,
                regwrite1_MEM & rt1_eq_d1mem & d1mem_valid
                
            })
                4'b1???: ForwardB1 = 5'b01000;
                4'b01??: ForwardB1 = 5'b00010;
                4'b001?: ForwardB1 = 5'b10000;
                4'b0001: ForwardB1 = 5'b00100;
                default: ForwardB1 = 5'b00001;
            endcase

            // ForwardB2 logic
            casez ({
				regwrite2_EX  & rt2_eq_d2ex  & d2ex_valid,
                regwrite1_EX  & rt2_eq_d1ex  & d1ex_valid,
                regwrite2_MEM & rt2_eq_d2mem & d2mem_valid,
                regwrite1_MEM & rt2_eq_d1mem & d1mem_valid
                
            })
                4'b1???: ForwardB2 = 5'b01000;
                4'b01??: ForwardB2 = 5'b00010;
                4'b001?: ForwardB2 = 5'b10000;
                4'b0001: ForwardB2 = 5'b00100;
                default: ForwardB2 = 5'b00001;
            endcase
        end
    end
endmodule