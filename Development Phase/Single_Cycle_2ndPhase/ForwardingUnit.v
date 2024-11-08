module forwarding_unit(
  input [4:0] RS1_IDEX,
  input [4:0] RS2_IDEX,
  input [4:0] RD_EXMEM,
  input [4:0] RD_MEMWB,
  
  input rst,
  input writeBack_EXMEM,
  input writeBack_MEMWB,
  output reg [1:0] ForwardA,
  output reg [1:0] ForwardB

  );

  always @(*)
    begin
    if (rst) begin
      ForwardA <= 2'b00;
      ForwardB <= 2'b00;

    end 
	 
    else begin
	 
		begin
      // ForwardA logic
      if((writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == RS1_IDEX)))
        ForwardA <= 2'b10;
      else if (writeBack_MEMWB && (RD_MEMWB != 5'b0) &&
          !((writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM != RS1_IDEX)))&& (RD_MEMWB== RS1_IDEX))
        ForwardA <= 2'b01;
      else
        ForwardA <= 2'b00;
		end
		
		
		
		begin
      // ForwardB logic
      if((writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == RS2_IDEX)))
        ForwardB <= 2'b10;
      else if (writeBack_MEMWB && (RD_MEMWB != 5'b0) &&
          !((writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM != RS2_IDEX))) && (RD_MEMWB== RS2_IDEX))
        ForwardB <= 2'b01;
      else
        ForwardB <= 2'b00;
		 end
       end
    end
endmodule