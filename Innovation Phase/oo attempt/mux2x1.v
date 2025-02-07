module mux2x1 #(parameter size = 32) (in1, in2, s, out);

	// inputs	
	input s;
	input [size-1:0] in1, in2; // size was 33 bits instead of 32, fixed.
	
	// outputs
	output [size-1:0] out;

	// Unit logic
	assign out = (~s) ? in1 : in2;
	
endmodule
/////////////////////////////////
module mux4x1 #(parameter size = 32) (in1, in2, in3, in4, s, out);

	// inputs	
	input [1:0]s;
	input [size-1:0] in1, in2, in3, in4; // size was 33 bits instead of 32, fixed.
	
	// outputs
	output reg [size-1:0] out;

	// Unit logic
	always @(*) begin
		case(s) 
			'b00: out <= in1;
			'b01: out <= in2;
			'b10: out <= in3;
			'b11: out <= in4;
			default: out <= in1;
			endcase
	end
	
endmodule