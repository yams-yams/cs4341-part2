//-------------------------------------------------
//
// Group SAMU Project Part 2
//
//-------------------------------------------------

//=================================================================
//
//Breadboard
//
//=================================================================
module breadboard(clock,reset,input1,input2,output1,opcode,error);
//=======================================================
//
// Parameter Definitions
//
//========================================================
input clock;
input reset;
input [31:0] input1;
input [31:0] input2;
input [3:0] opcode;
output [63:0] output1;
output [1:0] error;

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

wire [15:0][ 63:0] channels;
wire       [ 63:0] b;
wire       [ 63:0] unknown;

wire [15:0][ 1:0]  chErr;
wire       [ 1:0]   bErr;
wire       [ 1:0] unkErr;

reg [31:0] reg1;
reg [31:0] reg2;

reg [63:0] next;
wire [63:0] current;

DFF ACC1 [63:0] (clock, next, current);
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
// Error Reporting
//
//=======================================================
 
reg errHigh;
reg errLow;

//=======================================================
//
// Connect the MUX to the OpCodes
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
AddSub add1(reg2,reg1,modeSUB,outputADDSUB,Carry,ADDerror); 
Mult mult1(reg2, reg1, outputMULT);
Div div1(reg2,reg1,outputQuotient,DIVerror);
Mod mod1(reg2,reg1,outputRemainder,DIVerror);
NOT not1(reg2, outputNOT);
ANDER and1(reg2, reg1, outputAND);
ORER or1(reg2, reg1, outputOR);
NANDER nand1(reg2, reg1, outputNAND);
NORER nor1(reg2, reg1, outputNOR);
XORER xor1(reg2, reg1, outputXOR);
XNORER xnor1(reg2, reg1, outputXNOR);




OpMux muxOps(channels,select,b);
ErrMux muxErr(chErr,select,bErr);


always@(*)
begin
  
  reg1 = input1;
  reg2 = current[31:0]; //High 32 bits are dropped
  //Check for Subtraction Mode
  modeSUB=~opcode[3]&~opcode[2]&opcode[1]&~opcode[0];//0010, Channel 2
    
  // Set output of Operations to output1
  output1=b; //Just a jumper
  errHigh=DIVerror;
  errLow=ADDerror;

  // Set Errors of Operations to Error
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
   reg  [31:0] inp2;
   reg  [31:0] inp1;
   reg  [3:0] opcode;
   wire [63:0] out1;
   wire [1:0] error;
   reg [15:0] count;
   
//====================================================
//
// Create Breadboard
//
//====================================================
    breadboard bb8(clock,reset,inp1,inp2,out1,opcode,error);


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
// DISPLAY Thread
//
//====================================================
initial begin
  forever
    begin 
      case (opcode)
        0: $display("%32b ==> \n%64b         , NO-OP",bb8.current[31:0],bb8.b);
	1: $display("%32b  +  %32b = \n%64b  , ADD"  ,bb8.current[31:0],inp1,bb8.b);
	2: $display("%32b  -  %32b = \n%64b  , SUB"  ,bb8.current[31:0],inp1,bb8.b);
	3: $display("%32b  *  %32b = \n%64b  , MULT"  ,bb8.current[31:0],inp1,bb8.b);
	4: $display("%32b  /  %32b = \n%64b  , DIV"  ,bb8.current[31:0],inp1,bb8.b);
	5: $display("%32b  MOD  %32b = \n%64b  , MOD"  ,bb8.current[31:0],inp1,bb8.b);
	6: $display("NOT  %32b = \n%64b  , NOT"  ,bb8.current[31:0],bb8.b);
	7: $display("%32b AND %32b = \n%64b  , AND"  ,bb8.current[31:0],inp1,bb8.b);
	8: $display("%32b OR %32b = \n%64b  , OR"  ,bb8.current[31:0],inp1,bb8.b);
	9: $display("%32b NAND %32b = \n%64b  , NAND"  ,bb8.current[31:0],inp1,bb8.b);
	10: $display("%32b NOR %32b = \n%64b  , NOR"  ,bb8.current[31:0],inp1,bb8.b);
	11: $display("%32b XOR %32b = \n%64b  , XOR"  ,bb8.current[31:0],inp1,bb8.b);
	12: $display("%32b XNOR %32b = \n%64b  , XNOR"  ,bb8.current[31:0],inp1,bb8.b);
        13: $display("%32b ==> \n%64b         , RESET",32'b00000000000000000000000000000000,bb8.b);
		 
      endcase
 
      #10;
    end
end
//====================================================
//
// STIMULOUS
//
//====================================================

	initial begin//Start Stimulous Thread
	#6;	
	//---------------------------------
	inp1=32'b00000000000000000000000000000000;
	opcode=4'b0000;//NO-OP
	#10; 
	//---------------------------------
	inp1=32'b00000000000000000000000000000000;
	opcode=4'b1101;//RESET
	#10
	//---------------------------------	
	inp1=32'b00010100001100000101111001111001;
	opcode=4'b0001;//ADD
	#10;
	//---------------------------------	
	inp1=32'b00000000000000000000000001111001;
	opcode=4'b0010;//SUB
	#10
	//---------------------------------
        inp1=32'b00000000000000000000000001111001;
	opcode=4'b0011;//MULT
	#10
	//---------------------------------
        inp1=32'b00000000000000000000000000000011;
	opcode=4'b0100;//DIV
	#10
	//---------------------------------
        inp1=32'b00010100000000000000000000000001;
	opcode=4'b0101;//MOD
	#10
	//---------------------------------
        inp1=32'b11100111001110011100111001110011;
	opcode=4'b0110;//NOT
	#10
	//---------------------------------
        inp1=32'b00000000000000000000111111111011;
	opcode=4'b0111;//AND
	#10
	//---------------------------------
        inp1=32'b01110000000000001110000001111001;
	opcode=4'b1000;//OR
	#10
	//---------------------------------
        inp1=32'b01111111100000111111100001100111;
	opcode=4'b1001;//NAND
	#10
	//---------------------------------
        inp1=32'b01111000000000000111000000110001;
	opcode=4'b1010;//NOR
	#10
	//---------------------------------
        inp1=32'b00011000001110000101001100010100;
	opcode=4'b1011;//XOR
	#10
	//---------------------------------
        inp1=32'b11100011000100110111000110110001;
	opcode=4'b1100;//XNOR
	#10
	//---------------------------------

	$finish;
	end

endmodule
