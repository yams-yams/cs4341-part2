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
wire       [ 3:0] unknown;

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
 

//reg errHigh;
reg errLow;

//=======================================================
//
// Connect the MUX to the OpCodes
//
// Channel 0, Opcode 0000, NOOP Addition
// Channel 1, Opcode 0001, Addition Subtraction
// Channel 2, Opcode 0010, Subtraction Division (Behavioral)
// Channel 3, Opcode 0011, Multiplication Modulus (Behavioral)
// Channel 4, Opcode 0100, Division AND
// Channel 5, Opcode 0101, Modulus NAND
// Channel 6, Opcode 0110, NOT OR
// Channel 7, Opcode 0111, AND NOR
// Channel 8, Opcode 1000, OR NOT
// Channel 9, Opcode 1001, NAND NOOP
// Channel 10, Opcode 1010, NOR XOR
// Channel 11, Opcode 1011, XOR XNOR
// Channel 12, Opcode 1100, XNOR
// Channel 13, Opcode 1101, RESET
//
//=======================================================
 
assign channels[ 0]=current;
assign channels[ 1]=outputADDSUB;
assign channels[ 2]=outputADDSUB;
assign channels[ 3]=0;//Multiplication
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
assign chErr[ 2]={1'b0,errLow};
assign chErr[ 3]={1'b0,errLow};
//assign chErr[ 2]={errHigh,1'b0};
//assign chErr[ 3]={errHigh,1'b0};
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
Div div1(reg2,reg1,outputQuotient,DIVerror);
Mod mod1(reg2,reg1,outputRemainder,DIVerror);
OpMux muxOps(channels,select,b);
ErrMux muxErr(chErr,select,bErr);


//=============================
//
// Perform Logic Gate Operations
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
  
  reg1 = input1;
  reg2 = current[31:0]; //High 32 bits are dropped
  //Check for Subtraction Mode
  modeSUB=~opcode[3]&~opcode[2]&opcode[1]&~opcode[0];//0010, Channel 2
    
  // Set output of Operations to output1
  output1=b; //Just a jumper
  //errHigh=DIVerror;
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
        0: $display("%32b ==> \n%32b         , NO-OP",bb8.current,bb8.b);
        13: $display("%32b ==> \n%64b         , RESET",32'b00000000000000000000000000000000,bb8.b);
	1: $display("%32b  +  %32b \n= %64b  , ADD"  ,bb8.current,inp1,bb8.b);
	//9: $display("%4b AND %4b = %4b  , AND"  ,bb8.cur,inputA,bb8.b);
	//10: $display("%4b OR %4b = %4b  , OR"  ,bb8.cur,inputA,bb8.b);		 
	//11: $display("%4b XOR %4b = %4b  , XOR"  ,bb8.cur,inputA,bb8.b);
		 
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
	inp1=32'b00000000000000000000000000000001;
	opcode=4'b0001;//ADD
	#10;
	//---------------------------------	
	inp1=32'b00000000000000000000000000000001;
	opcode=4'b0001;//ADD
	#10
	//---------------------------------

	$finish;
	end

endmodule
