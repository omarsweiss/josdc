// register file contains 32 register

module registerFile (clk, rst, we, we2, 
					 readRegister1_1, readRegister2_1,readRegister1_2, readRegister2_2,  writeRegister, writeRegister2,
					 writeData, writeData2, readData1_1, readData2_1, readData1_2, readData2_2);

	// inputs
	input wire clk, rst, we, we2;
	input wire [4:0] readRegister1_1, readRegister2_1,readRegister1_2, readRegister2_2, writeRegister, writeRegister2;
	input wire [31:0] writeData, writeData2;
	
	// outputs
	output [31:0] readData1_1, readData2_1, readData1_2, readData2_2;
	
	// register file (registers)
	reg [31:0] registers [0:31];
	
	
	// Read from the register file
	
	assign	readData1_1 = registers[readRegister1_1];
	assign	readData2_1 = registers[readRegister2_1];
	assign	readData1_2 = registers[readRegister1_2];
	assign	readData2_2 = registers[readRegister2_2];
	
	always@(negedge clk,  negedge rst) begin : Write_on_register_file_block
	
		integer i;
		// Reset the register file
		if(~rst) begin
			for(i=0; i<32; i = i + 1) registers[i] = 0;
		end
		// Write to the register file
		else if(we) begin
			if(writeRegister == 'b0) registers[writeRegister] <= 0;
			else registers[writeRegister] <= writeData;
			if(we2) begin
				if(writeRegister2 == 'b0) registers[writeRegister2] <= 0;
				else registers[writeRegister2] <= writeData2;
			end
		end
		// Defualt to prevent latching
		else;
		
	end

endmodule