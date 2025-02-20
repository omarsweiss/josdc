module fetch_not_taken(
input clk,rst,jr, hold, correct_en,
input [9:0] reg1Addr, correction,
output flush_second,
output reg [9:0] nextPC_out,
output [9:0] return_addr1, return_addr2,BranchAddress_1,BranchAddress_2,
output [31:0] instruction_1, instruction_2
);


reg [9:0] nextPC;
wire [9:0] address_1, address_2, PC;
wire [5:0] opcode1, opcode2;
wire jump_1,jump_2,Branch_1,Branch_2;
wire [9:0] pc_plus;


assign pc_plus = PC[0] ? PC + 10'b1: PC + 10'd2;
assign flush_second = PC[0];

assign return_addr1 = PC + 10'b1;
assign return_addr2 = PC + 10'd2;

assign opcode1 = instruction_1[31:26];
assign opcode2 = instruction_2[31:26];
assign address_1 = instruction_1[9:0];
assign address_2 = instruction_2[9:0];
assign jump_1 = (opcode1 == 6'h2 || opcode1 == 6'h3);
assign jump_2 = (opcode2 == 6'h2 || opcode2 == 6'h3);

assign Branch_1 = (opcode1 == 6'h4 || opcode1 == 6'h5);
assign Branch_2 = (opcode2 == 6'h4 || opcode2 == 6'h5);

assign BranchAddress_1 = address_1 + (pc_plus - 1'b1);
assign BranchAddress_2 = address_2 + pc_plus;


always @(*) begin
    casez ({rst, correct_en ,jr, jump_1, jump_2})
        5'b0zzzz: nextPC = 10'b0000000000;      // Reset condition
        5'b11zzz: nextPC = correction;
		  5'b101zz: nextPC = reg1Addr;           // Jump register
        5'b1001z: nextPC = address_1;            // J-type instruction
		  5'b10001: nextPC = address_2;
        default:    nextPC = pc_plus;		  // Default case
    endcase
end




always @(*) begin
    casez ({rst, jr, Branch_1, jump_1, Branch_2, jump_2})
        6'b0zzzzz: nextPC_out = 10'b0000000000;      // Reset condition
		  6'b11zzzz: nextPC_out = reg1Addr;           // Jump register
        6'b101zzz: nextPC_out = BranchAddress_1;       
        6'b1001zz: nextPC_out = address_1;            // J-type instruction
        6'b10001z: nextPC_out = BranchAddress_2;
		  6'b100001: nextPC_out = address_2;
        default:         nextPC_out = pc_plus;            // Default case
    endcase
end




programCounter pc(.clk(clk), .rst(rst), .PCin(nextPC), .PCout(PC), .hold(hold));


instructionMemory IM_nt(.address_a(nextPC), .address_b(nextPC + 10'b1), .clock(clk), .q_a(instruction_1), .q_b(instruction_2));



endmodule