//-------------------------------------------------
//
// Behavioral Division
// Group SAMU Project Part 2
//
//-------------------------------------------------


module Div (dividend, divisor,quotient,remainder,error);
    input [31:0] dividend;
    input [31:0] divisor;
    output [63:0] quotient;
    output [63:0] remainder;
    output error;

    wire [31:0] dividend;
    wire [31:0] divisor;
    reg [63:0] quotient;
    reg [63:0] remainder;
    reg error;

    always @(dividend,divisor)
    begin
        quotient =dividend/divisor;
        remainder=dividend%divisor;
        error=~(divisor[3]|divisor[2]|divisor[1]|divisor[0]);
    end

endmodule


 
