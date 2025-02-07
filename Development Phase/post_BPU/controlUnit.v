 module controlUnit(opCode, funct,
				   RegDst, Branch, MemReadEn, MemtoReg,
				   ALUOp, MemWriteEn, RegWriteEn, ALUSrc,bne,jump,jal,jr); //I type and J type instructions are missing, and added bne for bneq instruction, added jump ctrl signal, added jr ctrl signal
				   
		
	// inputs 
	input wire [5:0] opCode, funct;
	
	// outputs (signals)
	output reg RegDst, Branch, MemReadEn, MemtoReg, MemWriteEn, RegWriteEn, ALUSrc,bne,jump,jal,jr;
	output reg [3:0] ALUOp;//Changed to 4 bits accomodate the added R-type instructions
	
	// parameters (opCodes/functs)
	parameter _RType = 6'h0, _addi = 6'h8, _ori_=6'hd, _xori_=6'he, _andi_=6'hc, _slti_=6'ha, _lw = 6'h23, _sw = 6'h2b, _beq = 6'h4, _j_ = 6'h2, _jal_ = 6'h3, _bne_ = 6'h5;
	parameter _add_ = 6'h20, _sub_ = 6'h22, _and_ = 6'h24, _or_ = 6'h25, _slt_ = 6'h2a, _xor_ = 6'h26, _nor_ = 6'h27, _sll_ = 6'h0, _srl_= 6'h2, _jr_ = 6'h8;
	//xor,nor,ori,xori,andi,sll,srl,slti,j,jr,jal,bne
	//pseudo bltz, bgez, sgt

	// unit logic - generate signals
	
	always @(*) begin
	
		RegDst = 1'b0; Branch = 1'b0; MemReadEn = 1'b0; MemtoReg = 1'b0;
		MemWriteEn = 1'b0; RegWriteEn = 1'b0; ALUSrc = 1'b0;
		ALUOp = 3'b0; bne = 1'b0; jump = 1'b0; jal = 1'b0; jr = 1'b0;
		
		case(opCode)
				
			_RType : begin
				
				
				
					
				case (funct) 
					
					_add_ : begin
						ALUOp = 4'b0000;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
						
					_sub_ : begin
						ALUOp = 4'b0001;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
						
					_and_ : begin
						ALUOp = 4'b0010;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
						
					_or_ : begin
						ALUOp = 4'b0011; // it was in decimal format, changed to binary,fixed.
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
						
					_slt_ : begin // added these R-type instructions
						ALUOp = 4'b0100;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
					_xor_ : begin
						ALUOp = 4'b0101;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
					_nor_ : begin
						ALUOp = 4'b0110;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
					_sll_ : begin
						ALUOp = 4'b0111;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
					_srl_ : begin
						ALUOp = 4'b1000;
						RegDst = 1'b1;
						Branch = 1'b0;
						MemReadEn = 1'b0;
						MemtoReg = 1'b0;
						MemWriteEn = 1'b0;
						RegWriteEn = 1'b1;
						ALUSrc = 1'b0;
					end
					_jr_ : begin
						RegDst = 1'b0;
				      Branch = 1'b0;
				      MemReadEn = 1'b0;
				      MemtoReg = 1'b0;
				      ALUOp = 4'b0000;
				      MemWriteEn = 1'b0;
						RegWriteEn = 1'b0;
						ALUSrc = 1'b0;
						jump = 1'b1;
						bne = 1'b0;
						jal = 1'b0;
						jr = 1'b1; //sus
					end
					default: ;
					
				endcase
				
			end
				
			_addi : begin
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 4'b0000;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b1;
				ALUSrc = 1'b1;				
			end
				
			_lw : begin
				RegDst = 1'b0; // was 1, fixed to 0.
				Branch = 1'b0;
				MemReadEn = 1'b1;//wrong, fixed
				MemtoReg = 1'b1;
				ALUOp = 4'b0000;
				MemWriteEn = 1'b0;//wrong,fixed.
				RegWriteEn = 1'b1;		
				ALUSrc = 1'b1;		
			end
				
			_sw : begin
				
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg= 1'b0;
				ALUOp = 4'b0000;
				MemWriteEn = 1'b1;
				RegWriteEn = 1'b0;
				ALUSrc = 1'b1;				
			end
				
			_beq : begin
				
				RegDst = 1'b0;
				Branch = 1'b1;
				MemReadEn = 1'b0;
				ALUOp = 4'b0001;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b0;
				ALUSrc = 1'b0;	// was wrong (1), changed to 0 (fixed)
				bne =  1'b0;
			end
			_ori_ : begin
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 4'b0011;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b1;
				ALUSrc = 1'b1;	
			end
			_xori_ : begin//added i-type
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 4'b0101;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b1;
				ALUSrc = 1'b1;
		   end		
			
		   _andi_ : begin
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 4'b0010;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b1;
				ALUSrc = 1'b1;
			end	
			_slti_ : begin
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 4'b0100;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b1;
				ALUSrc = 1'b1;			
			end
			_bne_ : begin
				
				RegDst = 1'b0;
				Branch = 1'b1;
				MemReadEn = 1'b0;
				ALUOp = 4'b0001;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b0;
				ALUSrc = 1'b0;	
				bne =  1'b1;//added bne control
				end
				
				_j_ : begin
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 4'b0000;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b0;
				ALUSrc = 1'b1;
			   jump = 1'b1;
				bne = 1'b0;
				jal = 1'b0;
			end
			_jal_ : begin
				RegDst = 1'b0;
				Branch = 1'b0;
				MemReadEn = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 4'b0000;
				MemWriteEn = 1'b0;
				RegWriteEn = 1'b1;
				ALUSrc = 1'b0;
			   jump = 1'b1;
				bne = 1'b0;
				jal = 1'b1;
			end
			
			default: ;
				
		endcase
			
	end
	
	
endmodule
