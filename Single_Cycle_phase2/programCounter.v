module programCounter (clk, rst, PCin, PCout);
	
	//inputs
	input clk, rst;
	input [9:0] PCin;
	
	//outputs 
	output reg [9:0] PCout;
	
	//Counter logic
	always@(posedge clk, negedge rst) begin
		if(~rst) begin
			PCout <= 9'b111111111;// should be all 0's maybe?
		end
		else begin
			PCout <= PCin;
		end
	end
	
endmodule
