
module hazard_detection(
  
  input  [4:0] rs1_ID, rt1_ID,  dest1_EXE, rs2_ID, rt2_ID,  dest2_EXE,
     
  input  mem_read1_EX ,regDest1_ID, mem_read2_EX, regDest2_ID,
  
  input jr, 
  
  output  ld_has_hazard, jr_has_hazard

);


assign ld_has_hazard = (mem_read1_EX && (rs1_ID == dest1_EXE || regDest1_ID && (rt1_ID == dest1_EXE)))
							||(mem_read2_EX && (rs1_ID == dest2_EXE || regDest1_ID && (rt1_ID == dest2_EXE)))
							||(mem_read1_EX && (rs2_ID == dest1_EXE || regDest2_ID && (rt2_ID == dest1_EXE)))
							||(mem_read2_EX && (rs2_ID == dest2_EXE || regDest2_ID && (rt2_ID == dest2_EXE)));


							
assign jr_has_hazard = (jr) && !ld_has_hazard;



endmodule
