module forwarding_unit(
  input [4:0] rs1_ex,
  input [4:0] rt1_ex,
  input [4:0] rs2_ex,
  input [4:0] rt2_ex,
  input [4:0] dest1_mem,
  input [4:0] dest2_mem,
  input [4:0] dest1_wb,
  input [4:0] dest2_wb,
  input [4:0] rt1_mem,
  input [4:0] rt2_mem,
  input rst,
  input regwrite1_mem,
  input regwrite2_mem,
  input regwrite1_wb,
  input regwrite2_wb,
  input MemWriteEn1_MEM,
  input MemWriteEn2_MEM,
  output reg [2:0] ForwardA1,
  output reg [2:0] ForwardB1,
  output reg [2:0] ForwardA2,
  output reg [2:0] ForwardB2,
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

  always @(*)
  
    if (~rst) begin
      ForwardA1 <= 3'b000;
      ForwardB1 <= 3'b000;
		ForwardA2 <= 3'b000;
      ForwardB2 <= 3'b000;
    end 
	 
    else begin
	 
		
      // ForwardA1 logic
      if(regwrite1_mem && (dest1_mem != 5'b0) && (dest1_mem == rs1_ex))
        ForwardA1 <= 3'b001;
		  
      else if (regwrite2_mem && (dest2_mem != 5'b0) && (dest2_mem== rs1_ex))
        ForwardA1 <= 3'b011;
		  
      else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rs1_ex))
        ForwardA1 <= 3'b010;
		  
		else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rs1_ex))
        ForwardA1 <= 3'b100;
		  
		else ForwardA1 <= 3'b000;
		
		
		
		// ForwardA2 logic
      if(regwrite1_mem && (dest1_mem != 5'b0) && (dest1_mem == rs2_ex))
        ForwardA2 <= 3'b001;
		  
      else if (regwrite2_mem && (dest2_mem != 5'b0) && (dest2_mem== rs2_ex))
        ForwardA2 <= 3'b011;
		  
      else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rs2_ex))
        ForwardA2 <= 3'b010;
		  
		else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rs2_ex))
        ForwardA2 <= 3'b100;
		  
		else ForwardA2 <= 3'b000;
		
		
      // ForwardB1 logic
      if(regwrite1_mem && (dest1_mem != 5'b0) && (dest1_mem == rt1_ex))
        ForwardB1 <= 3'b001;
		  
      else if (regwrite2_mem && (dest2_mem != 5'b0) && (dest2_mem== rt1_ex))
        ForwardB1 <= 3'b011;
		  
      else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rt1_ex))
        ForwardB1 <= 3'b010;
		  
		else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rt1_ex))
        ForwardB1 <= 3'b100;
		  
		else ForwardB1 <= 3'b000;
		
		
		// ForwardB1 logic
      if(regwrite1_mem && (dest1_mem != 5'b0) && (dest1_mem == rt2_ex))
        ForwardB2 <= 3'b001;
		  
      else if (regwrite2_mem && (dest2_mem != 5'b0) && (dest2_mem== rt2_ex))
        ForwardB2 <= 3'b011;
		  
      else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rt2_ex))
        ForwardB2 <= 3'b010;
		  
		else if (regwrite2_wb && (dest2_wb != 5'b0) && (dest2_wb== rt2_ex))
        ForwardB2 <= 3'b100;
		  
		else ForwardB2 <= 3'b000;
		
		
    end
endmodule