
module Gshare_predict
  #(
    parameter GSHARE_BITS_NUM = 3,
    parameter OPTION_OPERAND_WIDTH = 10
    )
   (
    input clk,
    input rst,
    output prediction,     
	 output [GSHARE_BITS_NUM - 1:0] state_index,
    
    input Branch_F,               

	 input taken,
    
    input Branch_EX,  

	 input [GSHARE_BITS_NUM - 1:0] prev_idx,
    input [OPTION_OPERAND_WIDTH-1:0]  brn_pc
    );

   localparam [1:0]
      STATE_STRONGLY_NOT_TAKEN = 2'b00,
      STATE_WEAKLY_NOT_TAKEN   = 2'b01,
      STATE_WEAKLY_TAKEN       = 2'b10,
      STATE_STRONGLY_TAKEN     = 2'b11;
		
   localparam FSM_NUM = 2 ** GSHARE_BITS_NUM;
	
   integer i = 0;

   reg [1:0] state [0:FSM_NUM-1];
	
   reg [GSHARE_BITS_NUM:0] brn_hist_reg = 0;


   
   assign state_index = brn_hist_reg[GSHARE_BITS_NUM - 1:0] ^ brn_pc[GSHARE_BITS_NUM - 1:0]; 

   assign prediction = state[state_index][1] && Branch_F;
									  

   always @(posedge clk) begin
      if (~rst) begin
         brn_hist_reg <= 0;
         
         for(i = 0; i < FSM_NUM; i = i + 1) begin
            state[i] <= STATE_STRONGLY_TAKEN;
         end
      end else begin

			
         if (Branch_EX) begin
			
			
            brn_hist_reg <= {brn_hist_reg[GSHARE_BITS_NUM - 1 : 0], taken};
				
				
            if (!taken) begin
               // change fsm state:
               //   STATE_STRONGLY_TAKEN -> STATE_WEAKLY_TAKEN
               //   STATE_WEAKLY_TAKEN -> STATE_WEAKLY_NOT_TAKEN
               //   STATE_WEAKLY_NOT_TAKEN -> STATE_STRONGLY_NOT_TAKEN
               //   STATE_STRONGLY_NOT_TAKEN -> STATE_STRONGLY_NOT_TAKEN
               case (state[prev_idx])
                  STATE_STRONGLY_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_NOT_TAKEN;
                  STATE_WEAKLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_NOT_TAKEN;
                  STATE_STRONGLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_NOT_TAKEN;
               endcase
            end else begin
               // change fsm state:
               //   STATE_STRONGLY_NOT_TAKEN -> STATE_WEAKLY_NOT_TAKEN
               //   STATE_WEAKLY_NOT_TAKEN -> STATE_WEAKLY_TAKEN
               //   STATE_WEAKLY_TAKEN -> STATE_STRONGLY_TAKEN
               //   STATE_STRONGLY_TAKEN -> STATE_STRONGLY_TAKEN
               case (state[prev_idx])
                  STATE_STRONGLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_NOT_TAKEN;
                  STATE_WEAKLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_TAKEN;
                  STATE_STRONGLY_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_TAKEN;
               endcase
            end
         end
      end
   end
endmodule