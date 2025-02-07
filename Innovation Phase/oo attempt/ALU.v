module ALU (operand1, operand2, opSel, result, zero,shamt);
	
	parameter data_width = 32;
	parameter sel_width = 4; //same as aluop
	
	// Inputs
	// ......
	input [4:0] shamt;
	input [data_width - 1 : 0] operand1, operand2;
	input [sel_width - 1 :0] opSel; //also same as aluop
	
	// Outputs
	// .......
	
	output reg [data_width - 1 : 0] result;
	output reg zero;
	
	// Operation Parameters
	// ....................
	parameter   _AND  = 'b010, _SUB  = 'b001, _ADD = 'b000,
				_OR   = 'b011, _SLT  = 'b100, _XOR = 'b101, _NOR = 'b110, _SLL = 'b111, _SLR = 'b1000;	//aluops were wrong, fixed
	
	// Perform Operation
	// .................
	
	always @ (*) begin
		
		case(opSel)
			
			_ADD: result = operand1 + operand2;
			
			_SUB: result = operand1 - operand2;
			
			_AND: result = operand1 & operand2;
			
			_OR : result = operand1 | operand2;
			
			_SLT: result = ($signed(operand1) < $signed(operand2)) ? 1 : 0;//operand1 instead of 2 xd
			
			_XOR: result = operand1 ^ operand2;
			
			_NOR: result = ~(operand1 | operand2);
			
			_SLL: result = operand1 << shamt;
			
			_SLR: result = $signed(operand1>>shamt);
			
			
			default:result =0; //Default case was missing, causing latches, we added it.

		endcase
	
	end
	
	always @ (*) begin 
		
		zero = (result == 'b0); //32'b0
	
	end

endmodule 
// Potential bug, zero always block is sensitive to everything (*), might cause it to reevaluate zero when it does not need to.
// fix: make it a blocking assignment in the always block above OR make the always block sensitive to (result)