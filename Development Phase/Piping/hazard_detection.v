
module hazard_detection(
  
  input  [4:0] rs_ID, rt_ID, dest_MEM, dest_EXE,dest_WB,
     
  input  mem_read_EX,branch, branchValid, writeBack_MEM, writeBack_EX, writeBack_WB, mem_to_reg_MEM, regDest_ID,
  
  
  input jump,jr,jal,
  
  output  ld_has_hazard, branch_has_hazard, hold,
  output reg [1:0]  forwardA_Branch, forwardB_Branch
);

wire branch_hold;

assign ld_has_hazard = (mem_read_EX && (rs_ID == dest_EXE || regDest_ID && (rt_ID == dest_EXE))); 

assign branch_has_hazard = ((branch && branchValid) || jump || jal || jr) && !hold;


assign branch_hold = branch && ( ((writeBack_EX && (dest_EXE != 5'b0) ) && ((dest_EXE == rs_ID) || (dest_EXE == rt_ID))) || (mem_to_reg_MEM && ((dest_MEM == rs_ID) || (dest_MEM == rt_ID))));


assign hold = ld_has_hazard || branch_hold;


/*branch forwarding is as follows = 00 => normal value/ 01=> from mem/ 10=> from writeback. a stall will happen
when dependecy with ex stage for one cycle, the result should appear in memory stage and then forwarded normally and the stall signal becomes 0
*/

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



endmodule
/*

assign forwardA_Branch = (writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == src1_ID));

//---------------------------------------------------------------------------------- rs2 branch forward

			 
assign forwardB_Branch= (writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == src2_ID));  

//----------------------------------------------------------------------------------execution stage stall signal

assign branch_hold = branch && ( ((writeBack_IDEX && (RD_IDEX != 5'b0) ) && ((RD_IDEX == src1_ID) || (RD_IDEX == src2_ID))) || (mem_to_reg_EXMEM && ((RD_EXMEM == src1_ID) || (RD_EXMEM == src2_ID))));


assign hold = ld_has_hazard || branch_hold;
*/