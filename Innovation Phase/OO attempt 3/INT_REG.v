module INT_REG(

input clk, rst, we_EX,
input [4:0] dst_EX, tag_EX,
input [31:0] data_EX,

output we_R,
output [4:0] dst_R, tag_R,
output [31:0] data_R

);

	reg we;
	
	reg [4:0] dst;
	
	reg [4:0] tag;
	
	reg [31:0] data;
	
	
	assign we_R   = we;
	
	assign dst_R  = dst;
	
	assign tag_R  = tag;
	
	assign data_R = data;
	
	
	always@(posedge clk) begin
	
		if (rst) begin
		
			we   <= 1'b0;
		
			dst  <= 5'b0;
			
			tag  <= 5'b0;
			
			data <= 32'b0;
		
		end
		
		else begin
		
			we   <= we_EX;
			
			dst  <= dst_EX;
			
			tag  <= tag_EX;
			
			data <= data_EX;
		
		end
	
	
	end

endmodule
