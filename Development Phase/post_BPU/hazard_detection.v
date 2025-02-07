
module hazard_detection(
  
  input  [4:0] rs_ID, rt_ID,  dest_EXE,
     
  input  mem_read_EX,branch, branchValid,  regDest_ID,
  
  input jr, prediction,
  
  output  ld_has_hazard, branch_has_hazard

);


assign ld_has_hazard = (mem_read_EX && (rs_ID == dest_EXE || regDest_ID && (rt_ID == dest_EXE))); 

assign branch_has_hazard = ((prediction ^ branchValid) || jr) && !ld_has_hazard;



endmodule
/*

branch forwarding is as follows = 00 => normal value/ 01=> from mem/ 10=> from writeback. a stall will happen
when dependecy with ex stage for one cycle, the result should appear in memory stage and then forwarded normally and the stall signal becomes 0


always @(*)begin

	if(branch && (writeBack_MEM && (dest_MEM == rs_ID && dest_MEM != 5'b0))) forwardA_Branch <= 2'b01;
	else begin
		if (branch && (writeBack_WB  && (dest_WB == rs_ID && dest_WB != 5'b0))) forwardA_Branch <= 2'b10;
		else forwardA_Branch <= 2'b00;
	end
	
	
	
	if(branch && (writeBack_MEM && (dest_MEM == rt_ID && dest_MEM != 5'b0))) forwardB_Branch <= 2'b01;
	else begin
		if (branch && (writeBack_WB  && (dest_WB == rt_ID && dest_WB != 5'b0))) forwardB_Branch <= 2'b10;
		else forwardB_Branch <= 2'b00;
	end
	

end

*/