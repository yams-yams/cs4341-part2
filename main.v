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
	6: $display("NOT  %32b ==> \n%64b  , NOT"  ,bb8.current[31:0],bb8.b);
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
	
        sideA=3;
        sideB=4;
        sideC=5;
        radius=5;
	
	$display();
	$display("--------------------------");
	$display("No-Op");
	inp1=32'd0  ; 	opcode=4'b0000;	#10;//No-Op
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);

	
	$display();
	$display("--------------------------");
	$display("Reset");
	inp1=32'd0  ; opcode=4'b1101;#10;//Reset 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error); 
	

	$display();
	$display("--------------------------");
	$display("Add 2");
	inp1=32'd2  ; opcode=4'b0001;#10;//Add 2 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);

	
	$display();
	$display("--------------------------");
	$display("Multiply by Radius");
	inp1=radius ; opcode=4'b0011;#10;//Multiply by R 
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);

        $display();
	$display("--------------------------");
	$display("No-Op");
	inp1=32'd0  ; 	opcode=4'b0000;	#10;//No-Op
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	//inp1=32'd0  ; 	opcode=4'b0000;	#5;//No-Op
	//$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);


	$display();
	$display("--------------------------");
	$display("Multiply by 314");
	inp1=32'd314; opcode=4'b0011;#10;//Multiply by 314
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	//inp1=32'd314; opcode=4'b0011;#5;//Multiply by 314
	//$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	
        $display();
	$display("--------------------------");
	$display("No-Op");
	inp1=32'd0  ; 	opcode=4'b0000;	#5;//No-Op
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	//inp1=32'd0  ; 	opcode=4'b0000;	#5;//No-Op
	//$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);

	hold=bb8.b;
	
	$display();
	$display("--------------------------");
	$display("Divide by 100");
	inp1=32'd100;	opcode=4'b0100;#10;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	//inp1=32'd100;	opcode=4'b0100;#5;
	//$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	//inp1=32'd0  ; 	opcode=4'b0000;	#5;//No-Op
	//$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	
	whole=bb8.b;//Divide by 100
	
	$display();
	$display("--------------------------");
	$display("Reset");
   	inp1=32'd0;	opcode=4'b1101;#10;//Reset
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);
	

	$display();
	$display("--------------------------");
	$display("Add back temp value");
 	inp1=hold   ; opcode=4'b0001;#10;//Add Temp back
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);

	$display();
	$display("--------------------------");
	$display("Modulus by 100");
	inp1=32'd100;	opcode=4'b0101;#10;
	$display("%b|%d|%b|%d|%b",clock,inp1,opcode,out1,error);

	fraction=bb8.b;

	$display("==========================");
	$display("Circumference of a circle with radius %2d is %3d.%-2d.",radius,whole,fraction);
	


        $finish;
	end

endmodule
