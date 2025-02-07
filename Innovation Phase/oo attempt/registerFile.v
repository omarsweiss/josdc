// register file contains 32 register

module registerFile (clk, rst, we, we2, 
					 readRegister1, readRegister2, writeRegister, writeRegister2,
					 writeData, writeData2, readData1, readData2);

	// inputs
	input wire clk, rst, we, we2;
	input wire [4:0] readRegister1, readRegister2, writeRegister, writeRegister2;
	input wire [31:0] writeData, writeData2;
	
	// outputs
	output [31:0] readData1, readData2;
	
	// register file (registers)
	reg [31:0] registers [0:31];
	
	
	// Read from the register file
	
	assign	readData1 = registers[readRegister1];
	assign	readData2 = registers[readRegister2];
	
	always@(negedge clk,  negedge rst) begin : Write_on_register_file_block
	
		integer i;
		// Reset the register file
		if(~rst) begin
			for(i=0; i<32; i = i + 1) registers[i] = 0;
		end
		// Write to the register file
		else if(we) begin
			if(writeRegister == 'b0) registers[writeRegister] <= writeData;
			else registers[writeRegister] <= writeData;
			if(we2) begin
				if(writeRegister2 == 'b0) registers[writeRegister2] <= writeData2;
				else registers[writeRegister2] <= writeData2;
			end
		end
		// Defualt to prevent latching
		else;
		
	end

endmodule