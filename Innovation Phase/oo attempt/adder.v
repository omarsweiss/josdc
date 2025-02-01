// parameterized adder module

module adder(in1, in2, out);
	// size parameter
	parameter size = 10;
	// inputs
	input [size-1:0] in1, in2;
	// outputs
	output [size-1:0] out;
	
	// summation
	assign out = in1 + in2;

endmodule

//