
module hazard_detection(
  
  input  [4:0] src1_ID, src2_ID, RD_IDEX, RD_EXMEM, RD_MEMWB,  
  input [4:0] dest_EXE,   
  input  mem_read_IDEX,branch, branchValid, writeBack_MEMWB, writeBack_EXMEM, writeBack_IDEX,mem_to_reg_EXMEM, 
  input [1:0]jump,
  output  ld_has_hazard, branch_has_hazard, hold,  
  output  forwardA_Branch, forwardB_Branch
);

wire branch_hold;
assign ld_has_hazard = (mem_read_IDEX && (src1_ID == dest_EXE || src2_ID == dest_EXE)); 

assign branch_has_hazard = (branch && branchValid) || jump[1] || jump[0];

/*branch forwarding is as follows = 00 => normal value/ 01=> from mem/ 10=> from writeback. a stall will happen
when dependecy with ex stage for one cycle, the result should appear in memory stage and then forwarded normally and the stall signal becomes 0
*/


//----------------------------------------------------------------------------------rs1 branch forward

assign forwardA_Branch = (writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == src1_ID));

//---------------------------------------------------------------------------------- rs2 branch forward

			 
assign forwardB_Branch= (writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == src2_ID));  

//----------------------------------------------------------------------------------execution stage stall signal

assign branch_hold = branch && ( ((writeBack_IDEX && (RD_IDEX != 5'b0) ) && ((RD_IDEX == src1_ID) || (RD_IDEX == src2_ID))) || (mem_to_reg_EXMEM && ((RD_EXMEM == src1_ID) || (RD_EXMEM == src2_ID))));


assign hold = ld_has_hazard || branch_hold;


endmodule