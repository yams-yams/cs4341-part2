//-------------------------------------------------
//
// Sample Testbench and Breadbaord
// Eric William Becker
// February 2, 2023
//
// For my students this semester.
//
//-------------------------------------------------



//=================================================================
//
//Breadboard
//
//=================================================================
module breadboard(A,B,C,opcode,error);
//=======================================================
//
// Parameter Definitions
//
//========================================================
input [31:0] A;
input [31:0] B;
input [3:0] opcode;
output [31:0] C;
output [1:0]error;

wire [31:0] A;
wire [31:0] B;
wire [3:0] opcode;
reg  [31:0] C;
reg  [1:0] error;


//----------------------------------


//=======================================================
//
// CONTROL
//
//========================================================

wire [15:0] select;
Dec4x16 dec1(opcode,select);



wire [15:0][ 3:0] channels;
wire       [ 3:0] b;
wire       [ 3:0] unknown;

wire [15:0][ 1:0]  chErr;
wire       [ 1:0]   bErr;
wire       [ 1:0] unkErr;

//=======================================================
//
// INTERFACES
//
//=======================================================

//----------
// ADDITION
//----------
wire [31:0] outputADDSUB;
wire ADDerror;
wire Carry;


//------------
// SUBTRACTION
//------------
reg modeSUB;

//----------------
//DIVISION/MODULUS
//----------------
wire [63:0] outputQuotient;
wire [63:0] outputRemainder;
wire DIVerror;


 

//=======================================================
//
// Error Reporting
//
//=======================================================
 

reg errHigh;
reg errLow;

//=======================================================
//
// Connect the MUX to the OpCodes
//
// Channel 4, Opcode 0100, Addition
// Channel 5, Opcode 0101, Subtraction
// Channel 6, Opcode 0110, Mulitplication
// Channel 7, Opcode 0111, Division (Behavioral)
// Channel 8, Opcode 1000, Modulus (Behavioral)
//
//=======================================================
 
assign channels[ 0]=unknown;
assign channels[ 1]=unknown;
assign channels[ 2]=unknown;
assign channels[ 3]=unknown;
assign channels[ 4]=outputADDSUB;
assign channels[ 5]=outputADDSUB;
assign channels[ 6]=unknown;
assign channels[ 7]=outputQuotient;
assign channels[ 8]=outputRemainder;
assign channels[ 9]=unknown;
assign channels[10]=unknown;
assign channels[11]=unknown;
assign channels[12]=unknown;
assign channels[13]=unknown;
assign channels[14]=unknown;
assign channels[15]=unknown;
 
assign chErr[ 0]=unkErr;
assign chErr[ 1]=unkErr;
assign chErr[ 2]=unkErr;
assign chErr[ 3]=unkErr;
assign chErr[ 4]={1'b0,errLow};
assign chErr[ 5]={1'b0,errLow};
assign chErr[ 6]=unkErr;
assign chErr[ 7]={errHigh,1'b0};
assign chErr[ 8]={errHigh,1'b0};
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
FourBitAddSub add1(B,A,modeSUB,outputADDSUB,Carry,ADDerror); 
BehavioralDivision div1(B,A,outputQuotient,outputRemainder,DIVerror);
StructMux4 muxOps(channels,select,b);
StructMux2 muxErr(chErr,select,bErr);


//====================================================
//
//Perform the gate-level operations in the Breadboard
//
//====================================================
 


always@(*)
begin
  
  //Check for Subtraction Mode
  modeSUB=~opcode[3]& opcode[2]&~opcode[1]& opcode[0];//0101, Channel 5
    
  // Set output of Operations to C
  C=b; //Just a jumper
  errHigh=DIVerror;
  errLow=ADDerror;

  // Set Errors of Operations to Error
  error=bErr;

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
   reg  [31:0] inputB;
   reg  [31:0] inputA;
   reg  [3:0] opcode;
   wire [31:0] outputC;
   wire [1:0] error;
   
//====================================================
//
// Create Breadboard
//
//====================================================
	breadboard bb8(inputA,inputB,outputC,opcode,error);

//====================================================
//
// STIMULOUS
//
//====================================================


	initial begin//Start Stimulous Thread
	#2;	
	
	//---------------------------------
	$write("[   B]");
	$write("[   A]");
	$write("[  OP]");
	$write("[   C]");
	$write("[ E]");
	$display(";");
	//---------------------------------
	inputB=32'b00000000000000000000000000000010;
	inputA=32'b00000000000000000000000000000010;
	opcode=4'b0100;//ADD
	#10;
	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%32b]",outputC);
 	$write("[%2b]",error);	
	$write(":Addition");
	$display(";");
	//---------------------------------
	inputB=32'b00000000000000000000000000000010;
	inputA=32'b00000000000000000000000000000100;
	opcode=4'b0101;//SUB
	#10	
	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%32b]",outputC);
 	$write("[%2b]",error);	
	$write(":Subtraction");
	$display(";");
	
	//---------------------------------
	inputB=32'b00000000000000000000000000000010;
	inputA=32'b00000000000000000000000000000010;
	opcode=4'b0111;//DIV
	#10	
	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%64b]",outputC);
 	$write("[%2b]",error);	;
	$write(":Division");
	$display(";");
	//---------------------------------
	inputB=32'b00000000000000000000000000000111;
	inputA=32'b00000000000000000000000000000100;
	opcode=4'b1000;//MOD
	#10	

	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%64b]",outputC);
 	$write("[%2b]",error);	;
	$write(":Modulus");
	$display(";");
	//---------------------------------
	inputB=32'b01000000000000000000000000000111;
	inputA=32'b01000000000000000000000000000100;
	opcode=4'b0100;//Addition with Error
	#10	

	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%64b]",outputC);
 	$write("[%2b]",error);		
	$write(":Addition with Error");
	$display(";");

	//---------------------------------
	inputB=32'b11100000000000000000000000000000;
	inputA=32'b01100000000000000000000000000000;
	opcode=4'b0101;//Subtraction with Error
	#10	

	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%64b]",outputC);
 	$write("[%2b]",error);		
	$write(":Subtraction with Error");
	$display(";");

	//---------------------------------
	inputB=32'b00000000000000000000000000000100;
	inputA=32'b00000000000000000000000000000000;
	opcode=4'b0111;//Division with Error
	#10	

	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%64b]",outputC);
 	$write("[%2b]",error);	;	
	$write(":Division with Error");
	$display(";");
	
	//---------------------------------
	inputB=32'b00000000000000000000000000000100;
	inputA=32'b00000000000000000000000000000000;
	opcode=4'b1000;//Modulus with Error
	#10	
	$write("[%32b]",inputB);
 	$write("[%32b]",inputA);
 	$write("[%4b]",opcode);
 	$write("[%64b]",outputC);
 	$write("[%2b]",error);	
	$write(":Modulus with Error");
	$display(";");
		


	$finish;
	end

endmodule
