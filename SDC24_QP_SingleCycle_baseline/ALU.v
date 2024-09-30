module ALU (operand1, operand2, opSel, result, zero );
	
	parameter data_width = 32;
	parameter sel_width = 3;
	
	// Inputs
	// ......
	
	input [data_width - 1 : 0] operand1, operand2;
	input [sel_width - 1 :0] opSel;
	
	// Outputs
	// .......
	
	output reg [data_width - 1 : 0] result;
	output reg zero;
	
	// Operation Parameters
	// ....................
	parameter   _AND  = 'b010, _SUB  = 'b001, _ADD = 'b000,
				_OR   = 'b011, _SLT  = 'b100;	//aluops were wrong, fixed
	
	// Perform Operation
	// .................
	
	always @ (*) begin
		
		case(opSel)//opSel is 3 bits
			
			_ADD: result = operand1 + operand2;
			
			_SUB: result = operand1 - operand2;
			
			_AND: result = operand1 & operand2;
			
			_OR : result = operand1 | operand2;
			
			_SLT: result = (operand2 < operand1) ? 1 : 0;
			default:result =0; //Default case was missing, causing latches, we added it.

		endcase
	
	end
	
	always @ (*) begin 
		
		zero = (result == 'b0);
	
	end

endmodule 
// Potential bug, zero always block is sensitive to everything (*), might cause it to reevaluate zero when it does not need to.
// fix: make it a blocking assignment in the always block above OR make the always block sensitive to (result)