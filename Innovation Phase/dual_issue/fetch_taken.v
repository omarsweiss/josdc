module fetch_taken(
input clk,rst,jr, hold, correct_en,
input [9:0] reg1Addr, correction,
output flush_second,
output [9:0] return_addr1, return_addr2,BranchAddress_1,BranchAddress_2,
output [31:0] instruction_1, instruction_2,
output reg [9:0] nextPC_out
);



reg [9:0] nextPC;
wire [9:0] address_1, address_2, PC;
wire [5:0] opcode_1, opcode_2;
wire jump_1,jump_2,Branch_1,Branch_2;
wire [9:0] pc_plus;


assign pc_plus = PC[0] ? PC + 10'b1: PC + 10'd2;
assign flush_second = PC[0] || Branch_1 || jump_1;


assign return_addr1 = PC + 10'b1;
assign return_addr2 = PC + 10'd2;

assign opcode_1 = instruction_1[31:26];
assign opcode_2 = instruction_2[31:26];
assign address_1 = instruction_1[9:0];
assign address_2 = instruction_2[9:0];
assign jump_1 = (opcode_1 == 6'h2 || opcode_1 == 6'h3);
assign jump_2 = (opcode_2 == 6'h2 || opcode_2 == 6'h3);
assign Branch_1 = (opcode_1 == 6'h4 || opcode_1 == 6'h5);
assign Branch_2 = (opcode_2 == 6'h4 || opcode_2 == 6'h5);

assign BranchAddress_1 = address_1 + (pc_plus - 1'b1);
assign BranchAddress_2 = address_2 + pc_plus;




always @(*) begin
    casez ({rst, hold, correct_en ,jr, Branch_1, jump_1, Branch_2, jump_2})
        8'b0zzzzzzz: nextPC = 10'b0;      // Reset condition
		  8'b11zzzzzz: nextPC = PC; 
        8'b101zzzzz: nextPC = correction;
		  8'b1001zzzz: nextPC = reg1Addr;           // Jump register
        8'b10001zzz: nextPC = BranchAddress_1;       
        8'b100001zz: nextPC = address_1;            // J-type instruction
        8'b1000001z: nextPC = BranchAddress_2;
		  8'b10000001: nextPC = address_2;
        default:         nextPC = pc_plus;            // Default case
    endcase
end



always @(*) begin
    casez ({rst, hold, jr, jump_1, jump_2})
        5'b0zzzz: nextPC_out = 10'b0000000000;      // Reset condition
		  5'b11zzz: nextPC_out = PC;
		  5'b101zz: nextPC_out = reg1Addr;           // Jump register
        5'b1001z: nextPC_out = address_1;            // J-type instruction
		  5'b10001: nextPC_out = address_2;
        default:    nextPC_out = pc_plus;		  // Default case
    endcase
end


programCounter pc(.clk(clk), .rst(rst), .PCin(nextPC), .PCout(PC), .hold(hold));
instructionMemory IM_nt(.address_a(nextPC), .address_b(nextPC + 10'b1), .clock(clk), .q_a(instruction_1), .q_b(instruction_2), .rden_a(rst), .rden_b(rst));




endmodule