//University of Jordan
// Comptuer Engineering Dept. 
// Course: Computer Design Lab. CPE 349
// Modified version of the library
// Eng. Muath Alhiari, Eng. Amal Quzmar

// Inverter
module INV (out, in);
   input in;
   output out;
   assign #1 out = ~in;
endmodule
//*****************************************************************

// 2-input AND gate
module AND (out, in1, in2);
   input in1, in2;
   output out;
   assign #1 out =  (in1 & in2);
endmodule
// 3-input AND gate
module AND3 (out, in1, in2, in3);
   input in1, in2, in3;
   output out;
   assign #1 out =  (in1 & in2 & in3);
endmodule
// 4-input AND gate
module AND4 (out, in1, in2, in3, in4);
   input in1, in2, in3, in4;
   output out;
   assign #1 out =  (in1 & in2 & in3 & in4);
endmodule

// 8-input And gate
module AND8 (out, in1, in2, in3, in4, in5, in6, in7, in8);
   input in1, in2, in3, in4, in5, in6, in7, in8;
   output out;
   wire w1,w2;
   AND4 o1(w1, in1, in2, in3, in4);
   AND4 o2(w2, in5, in6, in7, in8);
   AND  o3(out, w1, w2);
endmodule

//*****************************************************************

// 2-input OR gate
module OR (out, in1, in2);
   input in1, in2;
   output out;
   assign #1 out =  (in1 | in2);
endmodule
// 3-input OR gate
module OR3 (out, in1, in2, in3);
   input in1, in2, in3;
   output out;
   assign #1 out =  (in1 | in2 | in3);
endmodule
// 4-input OR gate
module OR4 (out, in1, in2, in3, in4);
   input in1, in2, in3, in4;
   output out;
   assign #1 out =  (in1 | in2 | in3 | in4);
endmodule

// 8-input OR gate
module OR8 (out, in1, in2, in3, in4, in5, in6, in7, in8);
   input in1, in2, in3, in4, in5, in6, in7, in8;
   output out;
   wire w1,w2;
   OR4 o1(w1, in1, in2, in3, in4);
   OR4 o2(w2, in5, in6, in7, in8);
   OR  o3(out, w1, w2);
endmodule
//*****************************************************************

// 2-input NAND gate
module NAND (out, in1, in2);
   input in1, in2;
   output out;
   assign #1 out =  ~(in1 & in2);
endmodule
// 3-input NAND gate
module NAND3 (out, in1, in2, in3);
   input in1, in2, in3;
   output out;
   assign #1 out =  ~(in1 & in2 & in3);
endmodule
// 4-input NAND gate
module NAND4 (out, in1, in2, in3, in4);
   input in1, in2, in3, in4;
   output out;
   assign #1 out =  ~(in1 & in2 & in3 & in4);
endmodule
//*****************************************************************

// 2-input NOR gate
module NOR (out, in1, in2);
   input in1, in2;
   output out;
   assign #1 out =  ~(in1 | in2);
endmodule
// 3-input NOR gate
module NOR3 (out, in1, in2, in3);
   input in1, in2, in3;
   output out;
   assign #1 out =  ~(in1 | in2 | in3);
endmodule
// 4-input NOR gate
module NOR4 (out, in1, in2, in3, in4);
   input in1, in2, in3, in4;
   output out;
   assign #1 out =  ~(in1 | in2 | in3 | in4);
endmodule
//*****************************************************************

// 2-input XOR gate
module XOR (out, in1, in2);
   input in1, in2;
   output out;
   assign #1 out = in1 ^ in2;
endmodule
// 3-input XOR gate
module XOR3 (out, in1, in2, in3);
   input in1, in2, in3;
   output out;
   assign #1 out =  (in1 ^ in2 ^ in3);
endmodule
// 4-input XOR gate
module XOR4 (out, in1, in2, in3, in4);
   input in1, in2, in3, in4;
   output out;
   assign #1 out =  (in1 ^ in2 ^ in3 ^ in4);
endmodule
//*****************************************************************

// 2-input XNOR gate
module XNOR (out, in1, in2);
   input in1, in2;
   output out;
   assign #1 out = ~(in1 ^ in2);
endmodule
// 3-input XNOR gate
module XNOR3 (out, in1, in2, in3);
   input in1, in2, in3;
   output out;
   assign #1 out =  ~(in1 ^ in2 ^ in3);
endmodule
// 4-input XNOR gate
module XNOR4 (out, in1, in2, in3, in4);
   input in1, in2, in3, in4;
   output out;
   assign #1 out =  ~(in1 ^ in2 ^ in3 ^ in4);
endmodule
//*******************************************************************

// Synchronous D Flip-flop with reset and active high enable(positive-edge trigger)
module DFF (Q, D, clk, reset,enable);
   input D, clk, reset,enable;
   output Q;
   reg Q;
   always @(posedge clk)
    begin
      #2;
      if (reset == 1)
        Q=0;
      else if(enable == 1)
        Q=D;
    end
endmodule
// Synchronous 4-bit register with reset and active high enable(positive-edge trigger)
module REG4 (Q, D, clk, reset, enable);
  input  clk, reset, enable;
  input  [3:0] D;         
  output [3:0] Q;         
 
DFF dff1(Q[0], D[0], clk, reset,enable);
DFF dff2(Q[1], D[1], clk, reset,enable);
DFF dff3(Q[2], D[2], clk, reset,enable);
DFF dff4(Q[3], D[3], clk, reset,enable);
endmodule
// Synchronous 8-bit register with reset and active high enable(positive-edge trigger)
module REG8 (Q, D, clk, reset, enable);
  input  clk, reset, enable;
  input  [7:0] D;    
  output [7:0] Q;         
 
 REG4 r1 (Q[3:0], D[3:0], clk, reset, enable);
 REG4 r2 (Q[7:4], D[7:4], clk, reset, enable);
endmodule
//*******************************************************************

// Synchronous D Flip-flop with reset and active high enable(negitive-edge trigger)
module DFFnegclk (Q, D, clk, reset,enable);
   input D, clk, reset,enable;
   output Q;
   reg Q;
   always @(negedge clk)
    begin
      #2;
      if (reset == 1)
       Q=0;
      else if(enable == 1)
       Q=D;
    end
endmodule

// Synchronous 4-bit register with reset and active high enable(negitive-edge trigger)
module REG4negclk (Q, D, clk, reset, enable);
  input  clk, reset, enable;
  input  [3:0] D;         
  output [3:0] Q;         
 
DFFnegclk dff1(Q[0], D[0], clk, reset,enable);
DFFnegclk dff2(Q[1], D[1], clk, reset,enable);
DFFnegclk dff3(Q[2], D[2], clk, reset,enable);
DFFnegclk dff4(Q[3], D[3], clk, reset,enable);
endmodule

// Synchronous 8-bit register with reset and active high enable(negitive-edge trigger)
module REG8negclk (Q, D, clk, reset, enable);
  input  clk, reset, enable;
  input  [7:0] D;    
  output [7:0] Q;         
 
 REG4negclk r1 (Q[3:0], D[3:0], clk, reset, enable);
 REG4negclk r2 (Q[7:4], D[7:4], clk, reset, enable);
   
endmodule
//*****************************************************************
// Asynchronous T Flip-flop with reset (Negative-edge trigger)
module TFF (Q, T, clk, reset);
   input T, clk, reset;
   output Q;
   reg Q;
   always @(negedge clk or posedge reset)
	begin
     	 #2;
       if (reset == 1)
         Q = 0;
       else if (T == 1) 
         Q = ~Q;
	end
endmodule
//*****************************************************************

// Latch with active high gate and a reset
module LATCH (Q, D, gate, reset);
   input D, gate, reset;
   output Q;
   reg Q;
   always @(gate or reset)
     if (reset == 1)
       #2 Q=0;
     else
       if (gate == 1)
         #2 Q=D;
endmodule
//*****************************************************************

// Tri-state buffer with active high control
module TRI (out, in, cntl);
   input in, cntl;
   output out;
   reg out;
   always @(in or cntl) begin
     #1;
     if (cntl == 1)
       out = in;
     else
       out = 1'bz;
   end
endmodule
