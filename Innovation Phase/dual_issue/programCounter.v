module programCounter (clk, rst, PCin, PCout, hold);
	
	//inputs
	input clk, rst, hold;
	input [9:0] PCin;
	
	//outputs 
	output reg [9:0] PCout;
	
	//Counter logic
	always@(posedge clk, negedge rst) begin
		if(~rst) begin
			PCout <= 10'b0;// should be all 0's maybe?
		end
		
		else if(~hold) PCout <= PCin;
			
		
	end
	
endmodule
