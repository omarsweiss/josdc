module programCounter(
	//inputs
	input clk, rst, hold,
	input [7:0] PCin,
	
	//outputs 
	output reg [7:0] PCout
	);
	//Counter logic
	always@(posedge clk, negedge rst) begin
		if(~rst) begin
			PCout <= 8'b0;
		end
		
		else if(~hold) PCout <= PCin;
			
		
	end
	
endmodule
