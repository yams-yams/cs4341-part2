module DFF(clock,in,out);
    input clock;
    input in;
    output out;
    reg out;

    always @(posedge clock)
    out = in;
endmodule
