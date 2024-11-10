module forwarding_unit(
  input [4:0] rs_ex,
  input [4:0] rt_ex,
  input [4:0] dest_mem,
  input [4:0] dest_wb,
  
  input rst,
  input regwrite_mem,
  input regwrite_wb,
  output reg [1:0] ForwardA,
  output reg [1:0] ForwardB

  );

  always @(*)
    begin
    if (~rst) begin
      ForwardA <= 2'b00;
      ForwardB <= 2'b00;

    end 
	 
    else begin
	 
		begin
      // ForwardA logic
      if((regwrite_mem && (dest_mem != 5'b0) && (dest_mem == rs_ex)))
        ForwardA <= 2'b10;
		  
      else if (regwrite_wb && (dest_wb != 5'b0) &&
          !((regwrite_mem && (dest_mem != 5'b0) && (dest_mem == rs_ex))) && (dest_wb== rs_ex))
			 
        ForwardA <= 2'b01;
      else
        ForwardA <= 2'b00;
		end
		
		
		
		begin
      // ForwardB logic
      if((regwrite_mem && (dest_mem != 5'b0) && (dest_mem == rt_ex)))
        ForwardB <= 2'b10;
		  
      else if (regwrite_wb && (dest_wb != 5'b0) &&
          !((regwrite_mem && (dest_mem != 5'b0) && (dest_mem == rt_ex))) && (dest_wb== rt_ex))
			 
        ForwardB <= 2'b01;
      else
        ForwardB <= 2'b00;
		 end
       end
    end
endmodule