
module hazard_detection(
  
  input  [4:0] rs_ID, rt_ID, dest_MEM, dest_EXE,
     
  input  mem_read_EX,branch, branchValid, writeBack_MEM, writeBack_EX,mem_to_reg_MEM, destReg_ID,
  
  input [1:0]jump,
  output  ld_has_hazard, branch_has_hazard, hold,  
  output  forwardA_Branch, forwardB_Branch
);

wire branch_hold;
assign ld_has_hazard = (mem_read_EX && (rs_ID == dest_EXE || destReg_ID && (rt_ID == dest_EXE))); 

assign branch_has_hazard = (branch && branchValid) || jump[1] || jump[0];

/*branch forwarding is as follows = 00 => normal value/ 01=> from mem/ 10=> from writeback. a stall will happen
when dependecy with ex stage for one cycle, the result should appear in memory stage and then forwarded normally and the stall signal becomes 0
*/


//----------------------------------------------------------------------------------rs1 branch forward

assign forwardA_Branch = (writeBack_MEM && (dest_MEM != 5'b0) && (dest_MEM == rs_ID));

//---------------------------------------------------------------------------------- rs2 branch forward

			 
assign forwardB_Branch= (writeBack_MEM && (dest_MEM != 5'b0) && (dest_MEM == rt_ID));  

//----------------------------------------------------------------------------------execution stage stall signal

assign branch_hold = branch && ( ((writeBack_EX && (dest_EXE != 5'b0) ) && ((dest_EXE == rs_ID) || (dest_EXE == rt_ID))) || (mem_to_reg_MEM && ((dest_MEM == rs_ID) || (dest_MEM == rt_ID))));


assign hold = ld_has_hazard || branch_hold;


endmodule