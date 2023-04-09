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
    
    //Set higher 32 bits of output to zero
    assign sum[32] = 1'b0 ^ mode;
    assign sum[33] = 1'b0 ^ mode;
    assign sum[34] = 1'b0 ^ mode;
    assign sum[35] = 1'b0 ^ mode;
    assign sum[36] = 1'b0 ^ mode;
    assign sum[37] = 1'b0 ^ mode;
    assign sum[38] = 1'b0 ^ mode;
    assign sum[39] = 1'b0 ^ mode;
    assign sum[40] = 1'b0 ^ mode;
    assign sum[41] = 1'b0 ^ mode;
    assign sum[42] = 1'b0 ^ mode;
    assign sum[43] = 1'b0 ^ mode;
    assign sum[44] = 1'b0 ^ mode;
    assign sum[45] = 1'b0 ^ mode;
    assign sum[46] = 1'b0 ^ mode;
    assign sum[47] = 1'b0 ^ mode;
    assign sum[48] = 1'b0 ^ mode;
    assign sum[49] = 1'b0 ^ mode;
    assign sum[50] = 1'b0 ^ mode;
    assign sum[51] = 1'b0 ^ mode;
    assign sum[52] = 1'b0 ^ mode;
    assign sum[53] = 1'b0 ^ mode;
    assign sum[54] = 1'b0 ^ mode;
    assign sum[55] = 1'b0 ^ mode;
    assign sum[56] = 1'b0 ^ mode;
    assign sum[57] = 1'b0 ^ mode;
    assign sum[58] = 1'b0 ^ mode;
    assign sum[59] = 1'b0 ^ mode;
    assign sum[60] = 1'b0 ^ mode;
    assign sum[61] = 1'b0 ^ mode;
    assign sum[62] = 1'b0 ^ mode;
    assign sum[63] = 1'b0 ^ mode;

always@(*)
begin
    overflow=c32^c31;
end
 
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


module Mult(multiplicand,multiplier,product);
    
    input [31:0] multiplicand, multiplier;
    output[63:0] product;
    wire [31:0] multiplicand, multiplier;
    reg[63:0] product;
    
    always@(*) begin
        product=multiplicand*multiplier;
    end
endmodule

