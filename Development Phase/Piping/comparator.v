module comparator (
  input [31:0] In1,
  input [31:0] In2,
  input bne,
  input reset,
  output reg branchValid
);


	
  always @(*)
	begin
    if (~reset) branchValid <=0;
    else begin
		if((bne && (In1 != In2)) || (!bne && (In1 == In2))) branchValid <= 1;
		else branchValid <= 0;
      end
  end

endmodule