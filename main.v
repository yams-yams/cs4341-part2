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
module breadboard(input1,input2,output1,opcode,error);
//=======================================================
//
// Parameter Definitions
//
//========================================================
input [31:0] input1;
input [31:0] input2;
input [3:0] opcode;
output [63:0] output1;
output [1:0]error;

wire [31:0] input1;
wire [31:0] input2;
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
wire [63:0] outputADDSUB;
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
 
assign channels[ 0]=outputADDSUB;
assign channels[ 1]=outputADDSUB;
assign channels[ 2]=outputQuotient;
assign channels[ 3]=outputRemainder;
assign channels[ 4]=outputAND;
assign channels[ 5]=outputNAND;
assign channels[ 6]=outputOR;
assign channels[ 7]=outputNOR;
assign channels[ 8]=outputNOT;
assign channels[ 9]=outputNOOP;
assign channels[10]=outputXOR;
assign channels[11]=outputXNOR;
assign channels[12]=unknown;
assign channels[13]=unknown;
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
AddSub add1(input2,input1,modeSUB,outputADDSUB,Carry,ADDerror); 
Div div1(input2,input1,outputQuotient,outputRemainder,DIVerror);
OpMux muxOps(channels,select,b);
ErrMux muxErr(chErr,select,bErr);



//=============================
//
//Perform Logic Gate Operations
//
//=============================
assign outputAND = input1&input2;
assign outputNAND = ~(input1&input2);
assign outputOR = input1|input2;
assign outputNOR = ~(input1|input2);
assign outputNOT = ~(input1);
assign outputNOT = ~(input1);
assign outputNOOP = input1;
assign outputXOR = input1^input2;
assign outputXNOR = input1^~input2;



//====================================================
//
//Perform the gate-level operations in the Breadboard
//
//====================================================
 


always@(*)
begin
  
  //Check for Subtraction Mode
  modeSUB=~opcode[3]& opcode[2]&~opcode[1]& opcode[0];//0101, Channel 5
    
  // Set output of Operations to output1
  output1=b; //Just a jumper
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
   reg  [31:0] inp2;
   reg  [31:0] inp1;
   reg  [3:0] opcode;
   wire [63:0] out1;
   wire [1:0] error;
   
//====================================================
//
// Create Breadboard
//
//====================================================
	breadboard bb8(inp1,inp2,out1,opcode,error);

//====================================================
//
// STIMULOUS
//
//====================================================


	initial begin//Start Stimulous Thread
	#2;	
	
	//---------------------------------
	$write("[   input2]");
	$write("[   input1]");
	$write("[   opcode]");
        $write("\n");
	$write("[   output1]");
	$write("[   error]");
	$display(";\n");
	//---------------------------------
	inp2=32'b01010101010101010101010101111110;
	inp1=32'b00101000100010000010000010001110;
	opcode=4'b0000;//ADD
	#20;
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%32b]",out1);
 	$write("[%2b]",error);	
	$write(":Addition");
	$display(";\n");
	//---------------------------------
	inp2=32'b00000000000000000000000000000010;
	inp1=32'b00000000000000000000000000000100;
	opcode=4'b0001;//SUB
	#20	
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%32b]",out1);
 	$write("[%2b]",error);	
	$write(":Subtraction");
	$display(";\n");
	
	//---------------------------------
	inp2=32'b00000000000000000000000000000010;
	inp1=32'b00000000000000000000000000000010;
	opcode=4'b0010;//DIV
	#20	
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	;
	$write(":Division");
	$display(";\n");
	//---------------------------------
	inp2=32'b00000000000000000000000000000111;
	inp1=32'b00000000000000000000000000000100;
	opcode=4'b0011;//MOD
	#20	

	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	;
	$write(":Modulus");
	$display(";\n");
	//---------------------------------
	inp2=32'b01000000000000000000000000000111;
	inp1=32'b01000000000000000000000000000100;
	opcode=4'b0000;//Addition with Error
	#10	

	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);		
	$write(":Addition with Error");
	$display(";\n");

	//---------------------------------
	inp2=32'b11100000000000000000000000000000;
	inp1=32'b01100000000000000000000000000000;
	opcode=4'b0001;//Subtraction with Error
	#10	

	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);		
	$write(":Subtraction with Error");
	$display(";\n");

	//---------------------------------
	inp2=32'b00000000000000000000000000000100;
	inp1=32'b00000000000000000000000000000000;
	opcode=4'b0010;//Division with Error
	#10	

	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	;	
	$write(":Division with Error");
	$display(";\n");
	
	//---------------------------------
	inp2=32'b00000000000000000000000000000100;
	inp1=32'b00000000000000000000000000000000;
	opcode=4'b0011;//Modulus with Error
	#10	
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":Modulus with Error");
	$display(";\n");
	
        //---------------------------------
	inp2=32'b00000000000000000000000011011011;
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b0100;//AND
	#10	
        
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":AND");
	$display(";\n");
	
        //---------------------------------
	inp2=32'b00000000000000000000000011011011;
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b0101;//NAND
	#10	
        
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":NAND");
	$display(";\n");
	
        //---------------------------------
	inp2=32'b00000000000000000000000011011011;
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b0110;//OR
	#10	
        
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":OR");
	$display(";\n");
	
        //---------------------------------
	inp2=32'b00000000000000000000000011011011;
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b0111;//NOR
	#10	
        
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":NOR");
	$display(";\n");
	
        //---------------------------------
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b1000;//NOT
	#10	
        
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":NOT");
	$display(";\n");
	
        //---------------------------------
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b1001;//NO-OP
	#10	
        
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":NO-OP");
	$display(";\n");
	
        //---------------------------------
	inp2=32'b00000000000000000000000011011011;
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b1010;//XOR
	#10	
        
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":XOR");
	$display(";\n");
	
        //---------------------------------
	inp2=32'b00000000000000000000000011011011;
	inp1=32'b00000000000000000000000001101101;
	opcode=4'b1011;//XNOR
	#10	
        
	$write("[%32b]",inp2);
 	$write("[%32b]",inp1);
 	$write("[%4b]",opcode);
        $write("\n");
 	$write("[%64b]",out1);
 	$write("[%2b]",error);	
	$write(":XNOR");
	$display(";\n");
	








	$finish;
	end

endmodule
