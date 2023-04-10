//============================================
//NOT operation
//============================================
module Not(input2,output1);
input  [31:0] input2;
output [63:0] output1;
wire   [31:0] input2;
reg    [63:0] output1;

reg    [63:0] result;

always@(*)
begin
 
	result=~input2;
	output1=result;
end
 
endmodule
//============================================
//AND operation
//============================================
module And(input1,input2,output1);
input  [31:0] input1;
input  [31:0] input2;
output [63:0] output1;
wire   [31:0] input1;
wire   [31:0] input2;
reg    [63:0] output1;

reg    [63:0] result;

always@(*)
begin
 
	result=input1&input2;
	output1=result;
end
 
endmodule
//============================================
//XOR operation
//============================================
module Xor(input1,input2,output1);
input  [31:0] input1;
input  [31:0] input2;
output [63:0] output1;
wire   [31:0] input1;
wire   [31:0] input2;
reg    [63:0] output1;

reg    [63:0] result;

always@(*)
begin
 
	result=input1^input2;
	output1=result;
end
 
endmodule

//============================================
// OR operation
//============================================
module Or(input1,input2,output1);
input  [31:0] input1;
input  [31:0] input2;
output [63:0] output1;
wire   [31:0] input1;
wire   [31:0] input2;
reg    [63:0] output1;

reg    [63:0] result;

always@(*)
begin
 
	result=input1|input2;
	output1=result;
end
 
endmodule
//============================================
//NAND operation
//============================================
module Nand(input1,input2,output1);
input  [31:0] input1;
input  [31:0] input2;
output [63:0] output1;
wire   [31:0] input1;
wire   [31:0] input2;
reg    [63:0] output1;

reg    [63:0] result;

always@(*)
begin
 
	result=~(input1&input2);
	output1=result;
end
 
endmodule
//============================================
//XNOR operation
//============================================
module Xnor(input1,input2,output1);
input  [31:0] input1;
input  [31:0] input2;
output [63:0] output1;
wire   [31:0] input1;
wire   [31:0] input2;
reg    [63:0] output1;

reg    [63:0] result;

always@(*)
begin
 
	result=~(input1^input2);
	output1=result;
end
 
endmodule

//============================================
// NOR operation
//============================================
module Nor(input1,input2,output1);
input  [31:0] input1;
input  [31:0] input2;
output [63:0] output1;
wire   [31:0] input1;
wire   [31:0] input2;
reg    [63:0] output1;

reg    [63:0] result;

always@(*)
begin
 
	result=~(input1|input2);
	output1=result;
end
 
endmodule

