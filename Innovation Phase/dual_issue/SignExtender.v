// sign Extender
// input is 16 bit, output is 32 bit
//wont compile, bug was the top level was not the same name as the module,fixed.
module SignExtender(in, out);

	//inputs
	input [15:0] in;
	
	//outputs
	output [31:0] out;
	
	// Unit logic
	assign out = {{16{in[15]}}, in};
	//note: only works for 16 bit inputs, no more no less
endmodule






