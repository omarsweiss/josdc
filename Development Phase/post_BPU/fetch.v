module fetch(
input clk, rst, taken, jr, hold,Branch_EX, prediction_EX,
input [9:0] reg1Addr,PCPlus1_EX, BranchAddress_EX, Branch_state_EX,
output prediction,
output [9:0] PCPlus1, PC, Branch_state_F, BranchAddress_F,
output [31:0] instruction);

reg [9:0] nextPC;
wire [9:0] address;   
wire [5:0] opCode;
wire [4:0] Branch_state;
wire Branch_F, misprediction, jump;

assign opCode = instruction[31:26];
assign address = instruction[9:0];
assign Branch_state_F = {5'b0,Branch_state};
assign jump = (opCode == 6'h2 || opCode == 6'h3);

always @(*) begin
    casez ({rst, misprediction, jr, taken, Branch_F, jump})
        6'b0zzzzz:        nextPC = 10'b0000000000;      // Reset condition
        6'b11z1zz:        nextPC = BranchAddress_EX;    // Misprediction, taken branch
        6'b11z0zz:        nextPC = PCPlus1_EX;         // Misprediction, not taken
        6'b10100z:        nextPC = reg1Addr;           // Jump register
        6'b100001:        nextPC = address;            // J-type instruction
        6'b100010: begin                               // Branch decision
            nextPC = prediction ? BranchAddress_F : PCPlus1;
        end
        default:         nextPC = PCPlus1;            // Default case
    endcase
end

assign Branch_F = (opCode == 6'h4 || opCode == 6'h5);
assign BranchAddress_F = address + PCPlus1;
assign misprediction = prediction_EX ^ taken;


Gshare_predict bpu(.clk(clk),.rst(rst),.prediction(prediction),.state_index(Branch_state),.Branch_F(Branch_F),
.taken(taken),.Branch_EX(Branch_EX),.prev_idx(Branch_state_EX[4:0]),.brn_pc(PC));






adder PCAdder(.in1(PC), .in2(10'b1), .out(PCPlus1));

programCounter pc(.clk(clk), .rst(rst), .PCin(nextPC), .PCout(PC), .hold(hold));

instructionMemory IM(.address(PC), .clock(~clk), .q(instruction));


endmodule

/*
//outermost mux
mux2x1 #(10) PCMux(.in1(PCPlus1), .in2(adderResult), .s(PCsrc), .out(branchAddress));//0 gives in1 1 gives in2, changed name from nextPC to branchaddress for jump implementation
//	jump or jr
mux2x1 #(10) JRMux(.in1(jaddress),.in2(reg1Addr),.s(jr),.out(jrAddress));
//branch or jump address
mux2x1 #(10) jumpMux(.in1(branchAddress),.in2(jrAddress),.s(jump),.out(nextPC));
*/