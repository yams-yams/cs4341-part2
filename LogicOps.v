//============================================
//NOT operation
//============================================
module NOT(input2,output1);
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
module ANDER(input1,input2,output1);
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
module XORER(input1,input2,output1);
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
module ORER(input1,input2,output1);
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
module NANDER(input1,input2,output1);
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
module XNORER(input1,input2,output1);
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
module NORER(input1,input2,output1);
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

