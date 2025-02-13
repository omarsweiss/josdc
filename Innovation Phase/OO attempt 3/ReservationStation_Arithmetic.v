module ReservationStation_Arithmetic #(parameter size = 8)(
    input clk, input rst, input stall, input arithmetic1, input arithmetic2, //If an instruction is arithmetic or otherwise
    input ready_rs1, ready_rt1, ready_rs2, ready_rt2, regwrite1, regwrite2, //If the corresponding field is ready or not
    input [4:0] rs1_tag, rt1_tag, rs2_tag, rt2_tag, dest1_tag, dest2_tag, dest1, dest2, //Tags from the RAT
    input [8:0] control1, control2, //Control signals for the ALUs
    input [31:0] val1_1, val2_1, val1_2, val2_2, //Operand Values
    input alu1_wr, alu2_wr, ld1_wr, ld2_wr,//If a value writes on a register or not
    input [4:0] alu1_res_tag, alu2_res_tag, ld1_res_tag, ld2_res_tag,//The corresponding tag for a result
    input [31:0] alu1_res, alu2_res, ld1_res, ld2_res,//The result 
    
    
    output write1, write2,//If an instruction writes or not
    output [4:0] dest1_out, dest2_out, dest1_tag_out, dest2_tag_out, //The destination register information
    output [8:0] control_out1, control_out2,
    output [31:0] val1_1_out, val2_1_out, val1_2_out, val2_2_out,

    output full_RSA
);




reg busy [size -1: 0];
reg write [size -1: 0];
reg ready_rs [size -1: 0];
reg ready_rt [size -1: 0];
reg [8:0] control [size -1: 0];
reg [4:0] dst [size -1: 0];
reg [4:0] dst_tag [size -1: 0];
reg [4:0] tag1 [size -1: 0];
reg [4:0] tag2 [size -1: 0];
reg[31:0] val1 [size -1: 0];
reg [31:0] val2 [size -1: 0];



reg[2:0] issue1, issue2, disp1, disp2;

  // Create a 8-bit ready vector. A slot is ready for dispatch if both operands are ready.
  wire [7:0] ready_vector;
  assign ready_vector[0] = (ready_rs[0]&&ready_rt[0]);
  assign ready_vector[1] = (ready_rs[1]&&ready_rt[1]);
  assign ready_vector[2] = (ready_rs[2]&&ready_rt[2]);
  assign ready_vector[3] = (ready_rs[3]&&ready_rt[3]);
	assign ready_vector[4] = (ready_rs[4]&&ready_rt[4]);
  assign ready_vector[5] = (ready_rs[5]&&ready_rt[5]);
  assign ready_vector[6] = (ready_rs[6]&&ready_rt[6]);
  assign ready_vector[7] = (ready_rs[7]&&ready_rt[7]);
  // First dispatch: use a priority encoder to select the first ready slot.
  wire [2:0] slot1;
  wire valid1;
  priority_encoder #(8) pe1 (
      .in(ready_vector),
      .index(slot1),
      .valid(valid1)
  );

  // Mask out the first selected slot for the second encoder.
  wire [7:0] mask;
  assign mask = 8'b00000001 << slot1; // one-hot mask for the first slot
  wire [7:0] ready_vector_masked;
  assign ready_vector_masked = ready_vector & ~mask;

  // Second dispatch: select the next ready slot.
  wire [2:0] slot2;
  wire valid2;
  priority_encoder #(8) pe2 (
      .in(ready_vector_masked),
      .index(slot2),
      .valid(valid2)
  );

assign control_out1 = control[slot1];
assign control_out2 = control[slot2];
assign dest1_out = dst[slot1];
assign dest2_out = dst[slot2];
assign dest1_tag_out = dst_tag[slot1];
assign dest2_tag_out = dst_tag[slot2];


assign val1_1_out = val1[slot1];
assign val2_1_out = val2[slot1];
assign val1_2_out = val1[slot2];
assign val2_2_out = val2[slot2];


assign write1 = write[slot1];
assign write2 = write[slot2];
assign full_RSA = (disp1 >= size -2) | ((disp2 >= size -2 ) & (arithmetic1 & arithmetic2));
always @(posedge clk, negedge rst) begin : name



    integer i, j;

    reg[2:0] i1, i2, d1, d2;

    if(~rst) begin
        for (i = 0; i<size; i= i+1) begin
            busy [i] <= 0;
            write [i] <= 0;
            ready_rs [i] <= 0;
            ready_rt [i] <= 0;
            control [i] <= 0;
            dst [i] <= 0;
            dst_tag [i] <= 0;
            tag1 [i] <= 0;
            tag2 [i] <= 0;
            val1 [i] <= 0;
            val2 [i] <= 0;

        end
			i1 = 0;
			i2 = 0;
			d1 = 0;
			d2 = 0;
        issue1<=0;
        issue2<=0;
        disp1<=0;
        disp2<=0;
    end

    else begin
        //Insert the instructions in their slots 
        if((arithmetic1 | arithmetic2) && ~stall &&(arithmetic1?~(dest1 == 5'b0):~(dest2==5'b0))) begin
            busy[disp1] <= 1'b1;
            ready_rs[disp1] <= arithmetic1? ready_rs1:ready_rs2;
            ready_rt[disp1] <= arithmetic1? ready_rt1:ready_rt2;
            control[disp1] <= arithmetic1? control1:control2;
            tag1[disp1] <= arithmetic1? rs1_tag: rs2_tag;
            tag2[disp1] <= arithmetic1? rt1_tag : rt2_tag;
            dst[disp1] <= arithmetic1? dest1:dest2;
            dst_tag[disp1] <= arithmetic1? dest1_tag: dest2_tag;
            val1[disp1] <= arithmetic1? val1_1: val1_2;
            val2[disp1] <= arithmetic1? val2_1:val2_2;
            write[disp1] <= arithmetic1? regwrite1:regwrite2;
        end
        if ((arithmetic1 & arithmetic2) && ~stall && ~(dest2==5'b0)) begin
            busy[disp2] <= 1'b1;
            ready_rs[disp2] <= ready_rs2;
            ready_rt[disp2] <= ready_rt2;
            control[disp2] <= control2;
            tag1[disp2] <= rs2_tag;
            tag2[disp2] <= rt2_tag;
            dst[disp2] <= dest2;
            dst_tag[disp2] <= dest2_tag;
            val1[disp2] <= val1_2;
            val2[disp2] <= val2_2;
            write[disp2] <= regwrite2;
        end




        //==============================CDB====================================//

        for (j = 0; j<size-2; j= j+1 ) begin
            //First ALU CDB
            if((alu1_res_tag==tag1[j]) && ~ready_rs[j] && busy[j] && alu1_wr) begin
                val1[j] <= alu1_res;
                ready_rs[j] <=1'b1;
            end
            if((alu1_res_tag==tag2[j]) && ~ready_rt[j] && busy[j] && alu1_wr) begin
                val2[j] <= alu1_res;
                ready_rt[j] <=1'b1;
            end
            //Second ALU CDB
            if((alu2_res_tag==tag1[j]) && ~ready_rs[j] && busy[j] && alu2_wr) begin
                val1[j] <= alu2_res;
                ready_rs[j] <=1'b1;
            end
            if((alu2_res_tag==tag2[j]) && ~ready_rt[j] && busy[j] && alu2_wr) begin
                val2[j] <= alu2_res;
                ready_rt[j] <=1'b1;
            end
            //First Load Word CDB
            if((ld1_res_tag==tag1[j]) && ~ready_rs[j] && busy[j] && ld1_wr) begin
                val1[j] <= ld1_res;
                ready_rs[j] <=1'b1;
            end
            if((ld1_res_tag==tag2[j]) && ~ready_rt[j] && busy[j] && ld1_wr) begin
                val2[j] <= ld1_res;
                ready_rt[j] <=1'b1;
            end
            //Second Load Word CDB
            if((ld2_res_tag==tag1[j]) && ~ready_rs[j] && busy[j] && ld2_wr) begin
                val1[j] <= ld2_res;
                ready_rs[j] <=1'b1;
            end
            if((ld2_res_tag==tag2[j]) && ~ready_rt[j] && busy[j] && ld2_wr) begin
                val2[j] <= ld2_res;
                ready_rs[j] <=1'b1;
            end
        end
        //==========================================================================
        d1 = 3'd7; //Default Value
        d2 = 3'd7;
        for (i=size-1; i>0; i=i-1 ) begin
            if(~busy[i] && ~((disp1 == i)&&(arithmetic1?~(dest1 == 5'b0):~(dest2==5'b0))) && ~((disp2 == i)&&~(dest2==5'b0))) d1 = i;
        end
        for (i =size -2 ; i>0; i= i-1 ) begin
            if(~busy[i] && (i != d1) &&~((disp1 == i)&&(arithmetic1?~(dest1 == 5'b0):~(dest2==5'b0))) && ~((disp2 == i)&&~(dest2==5'b0))) d2 = i;            
        end

        //Give priority to index 0
        if(~busy[0] && ~((disp1 == 0)&&(arithmetic1?~(dest1 == 5'b0):~(dest2==5'b0))) && ~((disp2 == 0)&&~(dest2==5'b0))) begin
            d2 = d1;
            d1 = 0;
        end
        if(d1 >= size-2) begin
            d1 = slot1;
            d2 = slot2;
        end
        disp1 <= d1;
        disp2 <= d2;
        busy[slot1] = 0;
        busy[slot2] = 0;
		  ready_rs[slot1] <= 0;
        ready_rt[slot1] <= 0;
		  ready_rs[slot2] <= 0;
        ready_rt[slot2] <= 0;
    end
end












endmodule