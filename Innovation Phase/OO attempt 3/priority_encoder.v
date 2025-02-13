// A simple combinational priority encoder module
module priority_encoder #(parameter WIDTH = 8) (
    input  [WIDTH-1:0] in,
    output reg [$clog2(WIDTH)-1:0] index,
    output valid
);
  assign valid = |in;  // valid if any bit is 1

  always @(*) begin
    // Here, lower-numbered slots have higher priority.
    casex (in)
      8'bxxxXxxx1: index = 3'd0;
      8'bxxxXxx10: index = 3'd1;
      8'bxxxXx100: index = 3'd2;
      8'bxxxX1000: index = 3'd3;
		8'bxxx10000: index = 3'd4;
		8'bxx100000: index = 3'd5;
		8'bx1000000: index = 3'd6;
		8'b10000000: index = 3'd7;
      default: index = 0;
    endcase
  end
endmodule