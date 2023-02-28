//-------------------------------------------------
//
// 1-Bit Full Adder
// Group SAAMU Project Part 2
//
//-------------------------------------------------



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
