module programCounter(
    input clk, rst, hold_set, hold_reset,
    input [9:0] PCin,
	 output reg hold,
    output reg [9:0] PCout
);



    

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            
            PCout <= 10'b0;
            hold <= 1'b0;
        end
        else begin
            
            if (hold_reset) begin
                
                hold <= 1'b0;
                PCout <= PCin;
            end
            else if (hold_set) begin
                
                hold <= 1'b1;
            end
            else if (~hold) begin
                
                PCout <= PCin;
            end
           
        end
    end

endmodule