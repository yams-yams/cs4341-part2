//-------------------------------------------------
//
// 32-Bit Adder/Subtractor with 64-Bit Outputs
// Group SAAMU Project Part 2
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
    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27,b28,b29,b30,b31,b32,b33,b34,b35,b36,b37,b38,b39,b40,b41,b42,b43,b44,b45,b46,b47,b48,b49,b50,b51,b52,b53,b54,b55,b56,b57,b58,b59,b60,b61,b62,b63; //XOR Interfaces
    wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,c60,c61,c62,c63,c64; //Carry Interfaces
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
    assign b32 = 1'b0 ^ mode;
    assign b33 = 1'b0 ^ mode;
    assign b34 = 1'b0 ^ mode;
    assign b35 = 1'b0 ^ mode;
    assign b36 = 1'b0 ^ mode;
    assign b37 = 1'b0 ^ mode;
    assign b38 = 1'b0 ^ mode;
    assign b39 = 1'b0 ^ mode;
    assign b40 = 1'b0 ^ mode;
    assign b41 = 1'b0 ^ mode;
    assign b42 = 1'b0 ^ mode;
    assign b43 = 1'b0 ^ mode;
    assign b44 = 1'b0 ^ mode;
    assign b45 = 1'b0 ^ mode;
    assign b46 = 1'b0 ^ mode;
    assign b47 = 1'b0 ^ mode;
    assign b48 = 1'b0 ^ mode;
    assign b49 = 1'b0 ^ mode;
    assign b50 = 1'b0 ^ mode;
    assign b51 = 1'b0 ^ mode;
    assign b52 = 1'b0 ^ mode;
    assign b53 = 1'b0 ^ mode;
    assign b54 = 1'b0 ^ mode;
    assign b55 = 1'b0 ^ mode;
    assign b56 = 1'b0 ^ mode;
    assign b57 = 1'b0 ^ mode;
    assign b58 = 1'b0 ^ mode;
    assign b59 = 1'b0 ^ mode;
    assign b60 = 1'b0 ^ mode;
    assign b61 = 1'b0 ^ mode;
    assign b62 = 1'b0 ^ mode;
    assign b63 = 1'b0 ^ mode;	


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
    FullAdder FA32(1'b0,b32,  c32,c33,sum[32]);
    FullAdder FA33(1'b0,b33,  c33,c34,sum[33]);
    FullAdder FA34(1'b0,b34,  c34,c35,sum[34]);
    FullAdder FA35(1'b0,b35,  c35,c36,sum[35]);
    FullAdder FA36(1'b0,b36,  c36,c37,sum[36]);
    FullAdder FA37(1'b0,b37,  c37,c38,sum[37]);
    FullAdder FA38(1'b0,b38,  c38,c39,sum[38]);
    FullAdder FA39(1'b0,b39,  c39,c40,sum[39]);
    FullAdder FA40(1'b0,b40,  c40,c41,sum[40]);
    FullAdder FA41(1'b0,b41,  c41,c42,sum[41]);
    FullAdder FA42(1'b0,b42,  c42,c43,sum[42]);
    FullAdder FA43(1'b0,b43,  c43,c44,sum[43]);
    FullAdder FA44(1'b0,b44,  c44,c45,sum[44]);
    FullAdder FA45(1'b0,b45,  c45,c46,sum[45]);
    FullAdder FA46(1'b0,b46,  c46,c47,sum[46]);
    FullAdder FA47(1'b0,b47,  c47,c48,sum[47]);
    FullAdder FA48(1'b0,b48,  c48,c49,sum[48]);
    FullAdder FA49(1'b0,b49,  c49,c50,sum[49]);
    FullAdder FA50(1'b0,b50,  c50,c51,sum[50]);
    FullAdder FA51(1'b0,b51,  c51,c52,sum[51]);
    FullAdder FA52(1'b0,b52,  c52,c53,sum[52]);
    FullAdder FA53(1'b0,b53,  c53,c54,sum[53]);
    FullAdder FA54(1'b0,b54,  c54,c55,sum[54]);
    FullAdder FA55(1'b0,b55,  c55,c56,sum[55]);
    FullAdder FA56(1'b0,b56,  c56,c57,sum[56]);
    FullAdder FA57(1'b0,b57,  c57,c58,sum[57]);
    FullAdder FA58(1'b0,b58,  c58,c59,sum[58]);
    FullAdder FA59(1'b0,b59,  c59,c60,sum[59]);
    FullAdder FA60(1'b0,b60,  c60,c61,sum[60]);
    FullAdder FA61(1'b0,b61,  c61,c62,sum[61]);
    FullAdder FA62(1'b0,b62,  c62,c63,sum[62]);
    FullAdder FA63(1'b0,b63,  c63,c64,sum[63]);

always@(*)
begin
    overflow=c64^c63;
end
 
endmodule

 
