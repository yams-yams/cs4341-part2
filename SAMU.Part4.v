//-------------------------------------------------
//
// Group SAMU Project Part 2
//
//-------------------------------------------------

//============================================
//
// LOGIC OPERATIONS
//
//============================================

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

//=============================================
//
// ARITHMETIC OPERATIONS
//
//=============================================

//=============================================
//
// Full Adder
//
//=============================================
module FullAdder(A,B,C,carry,sum);
        input A;
        input B;
        input C;
        output carry;
        output sum;

        wire A;
        wire B;
        wire C;
        reg carry;
        reg sum;
//---------------------------------------------

always@(*)
  begin
          sum= A^B^C;
          carry= ((A^B)&C)|(A&B);
  end

//---------------------------------------------
endmodule


//-------------------------------------------------
//
// 32-Bit Adder/Subtractor with 64-Bit Outputs
//
//-------------------------------------------------

module AddSub(inputA,inputB,mode,sum,carry,overflow);

    //parameters
    input [31:0] inputA;
    input [31:0] inputB;
    input mode;
    output [63:0] sum;
    output carry;
    output overflow;

    wire [31:0] inputA;
    wire [31:0] inputB;
    wire mode;

    reg carry;
    reg overflow;


    //Local Variables
    wire c0; //MOde assigned to C0
    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27,b28,b29,b30,b31; //XOR Interfaces
    wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32;//Carry Interfaces
    assign c0=mode;//Mode=0, Addition; Mode=1, Subtraction


    //Flip all Bits of InputB if Subtraction
    //    WIRE     WIRE     WIRE
    assign b0 = inputB[0] ^ mode;
    assign b1 = inputB[1] ^ mode;
    assign b2 = inputB[2] ^ mode;
    assign b3 = inputB[3] ^ mode;
    assign b4 = inputB[4] ^ mode;
    assign b5 = inputB[5] ^ mode;
    assign b6 = inputB[6] ^ mode;
    assign b7 = inputB[7] ^ mode;
    assign b8 = inputB[8] ^ mode;
    assign b9 = inputB[9] ^ mode;
    assign b10 = inputB[10] ^ mode;
    assign b11 = inputB[11] ^ mode;
    assign b12 = inputB[12] ^ mode;
    assign b13 = inputB[13] ^ mode;
    assign b14 = inputB[14] ^ mode;
    assign b15 = inputB[15] ^ mode;
    assign b16 = inputB[16] ^ mode;
    assign b17 = inputB[17] ^ mode;
    assign b18 = inputB[18] ^ mode;
    assign b19 = inputB[19] ^ mode;
    assign b20 = inputB[20] ^ mode;
    assign b21 = inputB[21] ^ mode;
    assign b22 = inputB[22] ^ mode;
    assign b23 = inputB[23] ^ mode;
    assign b24 = inputB[24] ^ mode;
    assign b25 = inputB[25] ^ mode;
    assign b26 = inputB[26] ^ mode;
    assign b27 = inputB[27] ^ mode;
    assign b28 = inputB[28] ^ mode;
    assign b29 = inputB[29] ^ mode;
    assign b30 = inputB[30] ^ mode;
    assign b31 = inputB[31] ^ mode;

    FullAdder FA0(inputA[0],b0,  c0,c1,sum[0]);
    FullAdder FA1(inputA[1],b1,  c1,c2,sum[1]);
    FullAdder FA2(inputA[2],b2,  c2,c3,sum[2]);
    FullAdder FA3(inputA[3],b3,  c3,c4,sum[3]);
    FullAdder FA4(inputA[4],b4,  c4,c5,sum[4]);
    FullAdder FA5(inputA[5],b5,  c5,c6,sum[5]);
    FullAdder FA6(inputA[6],b6,  c6,c7,sum[6]);
    FullAdder FA7(inputA[7],b7,  c7,c8,sum[7]);
    FullAdder FA8(inputA[8],b8,  c8,c9,sum[8]);
    FullAdder FA9(inputA[9],b9,  c9,c10,sum[9]);
    FullAdder FA10(inputA[10],b10,  c10,c11,sum[10]);
    FullAdder FA11(inputA[11],b11,  c11,c12,sum[11]);
    FullAdder FA12(inputA[12],b12,  c12,c13,sum[12]);
    FullAdder FA13(inputA[13],b13,  c13,c14,sum[13]);
    FullAdder FA14(inputA[14],b14,  c14,c15,sum[14]);
    FullAdder FA15(inputA[15],b15,  c15,c16,sum[15]);
    FullAdder FA16(inputA[16],b16,  c16,c17,sum[16]);
    FullAdder FA17(inputA[17],b17,  c17,c18,sum[17]);
    FullAdder FA18(inputA[18],b18,  c18,c19,sum[18]);
    FullAdder FA19(inputA[19],b19,  c19,c20,sum[19]);
    FullAdder FA20(inputA[20],b20,  c20,c21,sum[20]);
    FullAdder FA21(inputA[21],b21,  c21,c22,sum[21]);
    FullAdder FA22(inputA[22],b22,  c22,c23,sum[22]);
    FullAdder FA23(inputA[23],b23,  c23,c24,sum[23]);
    FullAdder FA24(inputA[24],b24,  c24,c25,sum[24]);
    FullAdder FA25(inputA[25],b25,  c25,c26,sum[25]);
    FullAdder FA26(inputA[26],b26,  c26,c27,sum[26]);
    FullAdder FA27(inputA[27],b27,  c27,c28,sum[27]);
    FullAdder FA28(inputA[28],b28,  c28,c29,sum[28]);
    FullAdder FA29(inputA[29],b29,  c29,c30,sum[29]);
    FullAdder FA30(inputA[30],b30,  c30,c31,sum[30]);
    FullAdder FA31(inputA[31],b31,  c31,c32,sum[31]);

    always@(*)
    begin
        overflow=c32^c31;
    end

    //Set higher 32 bits of output to zero
    assign sum[32] = 1'b0 ^ overflow;
    assign sum[33] = 1'b0 ^ overflow;
    assign sum[34] = 1'b0 ^ overflow;
    assign sum[35] = 1'b0 ^ overflow;
    assign sum[36] = 1'b0 ^ overflow;
    assign sum[37] = 1'b0 ^ overflow;
    assign sum[38] = 1'b0 ^ overflow;
    assign sum[39] = 1'b0 ^ overflow;
    assign sum[40] = 1'b0 ^ overflow;
    assign sum[41] = 1'b0 ^ overflow;
    assign sum[42] = 1'b0 ^ overflow;
    assign sum[43] = 1'b0 ^ overflow;
    assign sum[44] = 1'b0 ^ overflow;
    assign sum[45] = 1'b0 ^ overflow;
    assign sum[46] = 1'b0 ^ overflow;
    assign sum[47] = 1'b0 ^ overflow;
    assign sum[48] = 1'b0 ^ overflow;
    assign sum[49] = 1'b0 ^ overflow;
    assign sum[50] = 1'b0 ^ overflow;
    assign sum[51] = 1'b0 ^ overflow;
    assign sum[52] = 1'b0 ^ overflow;
    assign sum[53] = 1'b0 ^ overflow;
    assign sum[54] = 1'b0 ^ overflow;
    assign sum[55] = 1'b0 ^ overflow;
    assign sum[56] = 1'b0 ^ overflow;
    assign sum[57] = 1'b0 ^ overflow;
    assign sum[58] = 1'b0 ^ overflow;
    assign sum[59] = 1'b0 ^ overflow;
    assign sum[60] = 1'b0 ^ overflow;
    assign sum[61] = 1'b0 ^ overflow;
    assign sum[62] = 1'b0 ^ overflow;
    assign sum[63] = 1'b0 ^ overflow;

endmodule


//-------------------------------------------------
//
// Behavioral Division
//
//-------------------------------------------------

module Div (dividend, divisor,quotient,error);
    input [31:0] dividend;
    input [31:0] divisor;
    output [63:0] quotient;
    output error;

    wire [31:0] dividend;
    wire [31:0] divisor;
    reg [63:0] quotient;
    reg error;

    always @(dividend,divisor)
    begin
        quotient =dividend/divisor;
        error=~(divisor[3]|divisor[2]|divisor[1]|divisor[0]);
    end

endmodule

module Mod (dividend, divisor,remainder,error);
    input [31:0] dividend;
    input [31:0] divisor;
    output [63:0] remainder;
    output error;

    wire [31:0] dividend;
    wire [31:0] divisor;
    reg [63:0] remainder;
    reg error;

    always @(dividend,divisor)
    begin
        remainder=dividend%divisor;
        error=~(divisor[3]|divisor[2]|divisor[1]|divisor[0]);
    end

endmodule


module Mult(input [31:0] multiplicand, input [31:0] multiplier, output[63:0] product);

    reg [31:0] A, B, Q;
    reg C;
    integer k;
    assign product = {C, A, Q};

    always@(*) begin
        Q = multiplier;
        B = multiplicand;
        C = 0;
        A = 0;
        for (k = 0; k <= 31; k = k + 1)
            begin
                if (Q[0])
                    {C, A} = A + B;
                {C, A, Q} = ({C, A, Q} >> 1);
            end

    end
    endmodule

//===============================
// DFF
// ==============================

module DFF(clock,in,out);
    input clock;
    input in;
    output out;
    reg out;

    always @(posedge clock)
        out = in;
endmodule

//=================================================================
//
// 4x16 DECODER for Opcode Generation
//
//=================================================================
module Dec(binary,onehot);

    input [3:0] binary;
    output [15:0]onehot;

    assign onehot[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
    assign onehot[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
    assign onehot[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
    assign onehot[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
    assign onehot[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
    assign onehot[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
    assign onehot[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
    assign onehot[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
    assign onehot[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
    assign onehot[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
    assign onehot[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
    assign onehot[11]= binary[3]&~binary[2]& binary[1]& binary[0];
    assign onehot[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
    assign onehot[13]= binary[3]& binary[2]&~binary[1]& binary[0];
    assign onehot[14]= binary[3]& binary[2]& binary[1]&~binary[0];
    assign onehot[15]= binary[3]& binary[2]& binary[1]& binary[0];

endmodule

//=================================================================
//
// 64-bit, 16 channel Multiplexer for Operation Selection
//
//=================================================================

module OpMux(channels, select, b);
parameter chansize=64;
input [15:0][chansize-1:0] channels;
input [15:0]      select;
output      [63:0] b;


        assign b = ({chansize{select[15]}} & channels[15]) |
                   ({chansize{select[14]}} & channels[14]) |
                   ({chansize{select[13]}} & channels[13]) |
                   ({chansize{select[12]}} & channels[12]) |
                   ({chansize{select[11]}} & channels[11]) |
                   ({chansize{select[10]}} & channels[10]) |
                   ({chansize{select[ 9]}} & channels[ 9]) |
                   ({chansize{select[ 8]}} & channels[ 8]) |
                   ({chansize{select[ 7]}} & channels[ 7]) |
                   ({chansize{select[ 6]}} & channels[ 6]) |
                   ({chansize{select[ 5]}} & channels[ 5]) |
                   ({chansize{select[ 4]}} & channels[ 4]) |
                   ({chansize{select[ 3]}} & channels[ 3]) |
                   ({chansize{select[ 2]}} & channels[ 2]) |
                   ({chansize{select[ 1]}} & channels[ 1]) |
                   ({chansize{select[ 0]}} & channels[ 0]) ;

endmodule


//=================================================================
//
// 2x16 channel Multiplexer for Error Code
//
//=================================================================

module ErrMux(channels, select, b);
parameter chansize=2;
input [15:0][chansize-1:0] channels;
input [15:0]               select;
output      [chansize-1:0] b;


        assign b =  ({chansize{select[15]}} & channels[15]) |
                    ({chansize{select[14]}} & channels[14]) |
                    ({chansize{select[13]}} & channels[13]) |
                    ({chansize{select[12]}} & channels[12]) |
                    ({chansize{select[11]}} & channels[11]) |
                    ({chansize{select[10]}} & channels[10]) |
                    ({chansize{select[ 9]}} & channels[ 9]) |
                    ({chansize{select[ 8]}} & channels[ 8]) |
                    ({chansize{select[ 7]}} & channels[ 7]) |
                    ({chansize{select[ 6]}} & channels[ 6]) |
                    ({chansize{select[ 5]}} & channels[ 5]) |
                    ({chansize{select[ 4]}} & channels[ 4]) |
                    ({chansize{select[ 3]}} & channels[ 3]) |
                    ({chansize{select[ 2]}} & channels[ 2]) |
                    ({chansize{select[ 1]}} & channels[ 1]) |
                    ({chansize{select[ 0]}} & channels[ 0]) ;

endmodule

//=================================================================
//
//Breadboard
//
//=================================================================
module breadboard(clock,reset,input1,output1,opcode,error);
//=======================================================
//
// Parameter Definitions
//
//========================================================
input clock;
input reset;
input [31:0] input1;
input [3:0] opcode;
output [63:0] output1;
output [1:0] error;

wire [31:0] input1;
wire [3:0] opcode;
reg  [63:0] output1;
reg  [1:0] error;


//----------------------------------


//=======================================================
//
// CONTROL
//
//========================================================

wire [15:0] select;
Dec dec1(opcode,select);

wire [15:0][ 63:0] channels;
wire       [ 63:0] b;
wire       [ 63:0] unknown;

wire [15:0][ 1:0]  chErr;
wire       [ 1:0]   bErr;
wire       [ 1:0] unkErr;

reg [31:0] InMod;
reg [31:0] Feedback;

reg [63:0] next;
wire [63:0] current;

DFF Acc [63:0] (clock, next, current);
//=======================================================
//
// INTERFACES
//
//=======================================================

//----------
// ADDITION
//----------
wire [63:0] outputADDSUB;
wire ADDerror;
wire Carry;


//------------
// SUBTRACTION
//------------
reg modeSUB;

//----------------
//MULTIPLICATION/DIVISION/MODULUS
//----------------
wire [63:0] outputMULT;
wire [63:0] outputQuotient;
wire [63:0] outputRemainder;
wire DIVerror;


//-----------
//LOGIC GATES
//-----------
wire [63:0] outputAND;
wire [63:0] outputNAND;
wire [63:0] outputOR;
wire [63:0] outputNOR;
wire [63:0] outputNOT;
wire [63:0] outputNOOP;
wire [63:0] outputXOR;
wire [63:0] outputXNOR;

//=======================================================
//
// error Reporting
//
//=======================================================
 
reg errHigh;
reg errLow;

//=======================================================
//
// Connect the MUX to the opcodes
//
// Channel 0, Opcode 0000, NOOP 
// Channel 1, Opcode 0001, Addition 
// Channel 2, Opcode 0010, Subtraction 
// Channel 3, Opcode 0011, Multiplication (Behavioral)
// Channel 4, Opcode 0100, Division (Behavioral)
// Channel 5, Opcode 0101, Modulus (Behavioral)
// Channel 6, Opcode 0110, NOT 
// Channel 7, Opcode 0111, AND
// Channel 8, Opcode 1000, OR 
// Channel 9, Opcode 1001, NAND 
// Channel 10, Opcode 1010, NOR 
// Channel 11, Opcode 1011, XOR 
// Channel 12, Opcode 1100, XNOR
// Channel 13, Opcode 1101, RESET
//
//=======================================================
 
assign channels[ 0]=current;
assign channels[ 1]=outputADDSUB;
assign channels[ 2]=outputADDSUB;
assign channels[ 3]=outputMULT;//Multiplication
assign channels[ 4]=outputQuotient;
assign channels[ 5]=outputRemainder;
assign channels[ 6]=outputNOT;
assign channels[ 7]=outputAND;
assign channels[ 8]=outputOR;
assign channels[ 9]=outputNAND;
assign channels[10]=outputNOR;
assign channels[11]=outputXOR;
assign channels[12]=outputXNOR;
assign channels[13]=0;//RESET
assign channels[14]=unknown;
assign channels[15]=unknown;
 
assign chErr[ 0]={1'b0,errLow};
assign chErr[ 1]={1'b0,errLow};
assign chErr[ 2]={errHigh,1'b0};
assign chErr[ 3]={errHigh,1'b0};
assign chErr[ 4]=unkErr;
assign chErr[ 5]=unkErr;
assign chErr[ 6]=unkErr;
assign chErr[ 7]=unkErr;
assign chErr[ 8]=unkErr;
assign chErr[ 9]=unkErr;
assign chErr[10]=unkErr;
assign chErr[12]=unkErr;
assign chErr[11]=unkErr;
assign chErr[13]=unkErr;
assign chErr[14]=unkErr;
assign chErr[15]=unkErr;



//===========================================================
//
// INSTANTIATE MODULES
//
//===========================================================
AddSub add1(Feedback,InMod,modeSUB,outputADDSUB,Carry,ADDerror); 
Mult mult1(Feedback, InMod, outputMULT);
Div div1(Feedback,InMod,outputQuotient,DIVerror);
Mod mod1(Feedback,InMod,outputRemainder,DIVerror);
Not not1(Feedback, outputNOT);
And and1(Feedback, InMod, outputAND);
Or or1(Feedback, InMod, outputOR);
Nand nand1(Feedback, InMod, outputNAND);
Nor nor1(Feedback, InMod, outputNOR);
Xor xor1(Feedback, InMod, outputXOR);
Xnor xnor1(Feedback, InMod, outputXNOR);




OpMux muxOps(channels,select,b);
ErrMux muxErr(chErr,select,bErr);


always@(*)
begin
  
  InMod = input1;
  Feedback = current[31:0]; //High 32 bits are dropped
  //Check for Subtraction Mode
  modeSUB=~opcode[3]&~opcode[2]&opcode[1]&~opcode[0];//0010, Channel 2
    
  // Set output of Operations to output1
  output1=b; //Just a jumper
  errHigh=DIVerror;
  errLow=ADDerror;

  // Set errors of Operations to error
  error=bErr;

  //assign output=b;
  next=b;
end
 
endmodule


//====================================================
//
//TEST BENCH
//
//====================================================
module testbench();

//====================================================
//
//Local Variables
//
//====================================================
   reg clock;
   reg reset;
   reg  [31:0] inp1;
   reg  [3:0] opcode;
   wire [63:0] out1;
   wire [1:0] error;
   reg [15:0] count;
  
   reg [31:0] radius;
   reg [31:0] sideA;
   reg [31:0] sideB;
   reg [31:0] sideC;
   reg [31:0] base;
   reg [31:0] height;
   reg [31:0] width;
   reg [31:0] length;

   reg [63:0] hold;
   reg [63:0] whole;
   reg [63:0] fraction;


//====================================================
//
// Create Breadboard
//
//====================================================
    breadboard bb8(clock,reset,inp1,out1,opcode,error);


//====================================================
//
//CLOCK Thread
//
//====================================================
initial begin
    forever
        begin
            clock=0;
            #5;
            clock=1;
            #5;
                $display("Tick");
        end
    end

//====================================================
//
// STIMULOUS
//
//====================================================

	initial begin//Start Stimulous Thread
	#10
        sideA=3;
        sideB=4;
        sideC=5;
        base=3;
        height=4;
        length=6;
        width=7;
        radius=5;
	
        $display();
	$display("==========================");
	$display("1. The Perimeter of a Triangle with side lengths sideA=3, sideB=4, and sideC=5");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	
	$display();
	$display("--------------------------");
	$display("Add sideA");
	inp1=sideA  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op


	$display();
	$display("--------------------------");
	$display("Add sideB");
	inp1=sideB  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op


	$display();
	$display("--------------------------");
	$display("Add sideC");
	inp1=sideC  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;

	$display("==========================");
	$display("1. Perimeter of a triangle with side lengths %2d, %2d, and %2d is %3d.",sideA,sideB,sideC,whole);
			
        $display();
	$display("==========================");
	$display("2. The Perimeter of a Rectangle with side lengths length=6, width=7");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	
	$display();
	$display("--------------------------");
	$display("Add length");
	inp1=length  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op


	$display();
	$display("--------------------------");
	$display("Add width");
	inp1=width  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op


	$display();
	$display("--------------------------");
	$display("Multiply by 2");
	inp1=32'd2  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;

	$display("==========================");
	$display("2. Perimeter of a rectangle with side lengths %2d and %2d is %3d.",length,width,whole);

	
	$display();
	$display("==========================");
	$display("3. Circumference of a Circle with radius=5");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	

	$display();
	$display("--------------------------");
	$display("Add 2");
	inp1=32'd2  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	
	$display();
	$display("--------------------------");
	$display("Multiply by Radius");
	inp1=radius ; opcode=4'b0011;#5;//Multiply by R 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        
	$display();
	$display("--------------------------");
	$display("Multiply by 314");
	inp1=32'd314; opcode=4'b0011;#5;//Multiply by 314
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	
       	hold=out1;
	
	$display();
	$display("--------------------------");
	$display("Divide by 100");
	inp1=32'd100;	opcode=4'b0100;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;//Divide by 100
	
	$display();
	$display("--------------------------");
	$display("Reset");
   	inp1=32'd0;	opcode=4'b1101;#5;//Reset
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	

	$display();
	$display("--------------------------");
	$display("Add back temp value");
 	inp1=hold   ; opcode=4'b0001;#5;//Add Temp back
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Modulus by 100");
	inp1=32'd100;	opcode=4'b0101;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	fraction=out1;

	$display("==========================");
	$display("3. Circumference of a circle with radius %2d is %3d.%-2d.",radius,whole,fraction);
	
	
        $display();
	$display("==========================");
	$display("4. The Area of a triangle with base=3 and height=4");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	
	$display();
	$display("--------------------------");
	$display("Add base");
	inp1=base  ; opcode=4'b0001;#5;//Add base
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Multiply by height");
	inp1=height  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Multiply by 5");
	inp1=32'd5  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	hold=out1;

	$display();
	$display("--------------------------");
	$display("Divide by 10");
	inp1=32'd10  ; opcode=4'b0100;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;

	$display();
	$display("--------------------------");
	$display("Reset");
   	inp1=32'd0;	opcode=4'b1101;#5;//Reset
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	

	$display();
	$display("--------------------------");
	$display("Add back temp value");
 	inp1=hold   ; opcode=4'b0001;#5;//Add Temp back
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Modulus by 10");
	inp1=32'd10;	opcode=4'b0101;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	fraction=out1;

	$display("==========================");
	$display("4. Area of a triangle with base %2d and height %2d is %3d.%-2d",base,height,whole, fraction);
        
        $display();
	$display("==========================");
	$display("5. The Area of a Rectangle with length=6, width=7");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	
	$display();
	$display("--------------------------");
	$display("Add length");
	inp1=length  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        $display();
	$display("--------------------------");
	$display("Multiply by width");
	inp1=width  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;

	$display("==========================");
	$display("5. Area of a rectangle with length %2d and width %2d is %3d.",length,width,whole);

	$display();
	$display("==========================");
	$display("6. Area of a Circle with radius=5");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	

	$display();
	$display("--------------------------");
	$display("Add by radius");
	inp1=radius  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	
	$display();
	$display("--------------------------");
	$display("Multiply by radius");
	inp1=radius ; opcode=4'b0011;#5;//Multiply by R 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        
	$display();
	$display("--------------------------");
	$display("Multiply by 314");
	inp1=32'd314; opcode=4'b0011;#5;//Multiply by 314
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	
       	hold=out1;
	
	$display();
	$display("--------------------------");
	$display("Divide by 100");
	inp1=32'd100;	opcode=4'b0100;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;//Divide by 100
	
	$display();
	$display("--------------------------");
	$display("Reset");
   	inp1=32'd0;	opcode=4'b1101;#5;//Reset
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	

	$display();
	$display("--------------------------");
	$display("Add back temp value");
 	inp1=hold   ; opcode=4'b0001;#5;//Add Temp back
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Modulus by 100");
	inp1=32'd100;	opcode=4'b0101;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	fraction=out1;

	$display("==========================");
	$display("6. Area of a circle with radius %2d is %3d.%-2d.",radius,whole,fraction);
	
        $display();
	$display("==========================");
	$display("7. The Surface Area of a Cube with side length=6");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	
	$display();
	$display("--------------------------");
	$display("Add length");
	inp1=length  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        $display();
	$display("--------------------------");
	$display("Multiply by length");
	inp1=length  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        $display();
	$display("--------------------------");
	$display("Multiply by 6");
	inp1=32'd6  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op


	whole=out1;

	$display("==========================");
	$display("7. Surface Area of a cube with side length %2d is %3d.",length,whole);

        $display();
	$display("==========================");
	$display("8. The Volume of a Cube with side length=6");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	
	$display();
	$display("--------------------------");
	$display("Add length");
	inp1=length  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        $display();
	$display("--------------------------");
	$display("Multiply by length");
	inp1=length  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        $display();
	$display("--------------------------");
	$display("Multiply by length");
	inp1=length  ; opcode=4'b0011;#5;//Mult 2
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op


	whole=out1;

	$display("==========================");
	$display("8. Volume of a cube with side length %2d is %3d.",length,whole);

	
	$display();
	$display("==========================");
	$display("9. Surface Area of a Sphere with radius=5");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	

	$display();
	$display("--------------------------");
	$display("Add 4");
	inp1=32'd4  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	
	$display();
	$display("--------------------------");
	$display("Multiply by Radius");
	inp1=radius ; opcode=4'b0011;#5;//Multiply by R 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Multiply by Radius");
	inp1=radius ; opcode=4'b0011;#5;//Multiply by R 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        
	$display();
	$display("--------------------------");
	$display("Multiply by 314");
	inp1=32'd314; opcode=4'b0011;#5;//Multiply by 314
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	
       	hold=out1;
	
	$display();
	$display("--------------------------");
	$display("Divide by 100");
	inp1=32'd100;	opcode=4'b0100;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;//Divide by 100
	
	$display();
	$display("--------------------------");
	$display("Reset");
   	inp1=32'd0;	opcode=4'b1101;#5;//Reset
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	

	$display();
	$display("--------------------------");
	$display("Add back temp value");
 	inp1=hold   ; opcode=4'b0001;#5;//Add Temp back
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Modulus by 100");
	inp1=32'd100;	opcode=4'b0101;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	fraction=out1;

	$display("==========================");
	$display("9. Surface Area of a Sphere with radius %2d is %3d.%-2d.",radius,whole,fraction);
	
	
	$display();
	$display("==========================");
	$display("10. Volume of a Cylinder with radius=5 and height=4");
	$display("==========================");
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	inp1=32'd0  ; opcode=4'b1101;#5;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	

	$display();
	$display("--------------------------");
	$display("Add Radius");
	inp1=radius  ; opcode=4'b0001;#5;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	
	$display();
	$display("--------------------------");
	$display("Multiply by Radius");
	inp1=radius ; opcode=4'b0011;#5;//Multiply by R 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Multiply by Height");
	inp1=height ; opcode=4'b0011;#5;//Multiply by height
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

        
	$display();
	$display("--------------------------");
	$display("Multiply by 314");
	inp1=32'd314; opcode=4'b0011;#5;//Multiply by 314
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	
       	hold=out1;
	
	$display();
	$display("--------------------------");
	$display("Divide by 100");
	inp1=32'd100;	opcode=4'b0100;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	whole=out1;//Divide by 100
	
	$display();
	$display("--------------------------");
	$display("Reset");
   	inp1=32'd0;	opcode=4'b1101;#5;//Reset
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op
	

	$display();
	$display("--------------------------");
	$display("Add back temp value");
 	inp1=hold   ; opcode=4'b0001;#5;//Add Temp back
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	$display();
	$display("--------------------------");
	$display("Modulus by 100");
	inp1=32'd100;	opcode=4'b0101;#5;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	inp1=32'd0  ; opcode=4'b0000;#5;//No-Op

	fraction=out1;

	$display("==========================");
	$display("10. Volume of a Cylinder with radius %2d and height %2d is %3d.%-2d.",radius,height, whole,fraction);
	


        $finish;
	end

endmodule
