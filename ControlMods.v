
//===============================
// DFF
// ==============================

module DFF(clock,in,out);
    input clock;
    input in;
    output out;
    reg out;

    always @(posedge clock)
        out = in;
endmodule

//=================================================================
//
// 4x16 DECODER for Opcode Generation
//
//=================================================================
module Dec(binary,onehot);

    input [3:0] binary;
    output [15:0]onehot;

    assign onehot[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
    assign onehot[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
    assign onehot[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
    assign onehot[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
    assign onehot[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
    assign onehot[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
    assign onehot[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
    assign onehot[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
    assign onehot[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
    assign onehot[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
    assign onehot[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
    assign onehot[11]= binary[3]&~binary[2]& binary[1]& binary[0];
    assign onehot[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
    assign onehot[13]= binary[3]& binary[2]&~binary[1]& binary[0];
    assign onehot[14]= binary[3]& binary[2]& binary[1]&~binary[0];
    assign onehot[15]= binary[3]& binary[2]& binary[1]& binary[0];

endmodule

//=================================================================
//
// 64-bit, 16 channel Multiplexer for Operation Selection
//
//=================================================================

module OpMux(channels, select, b);
parameter chansize=64;
input [15:0][chansize-1:0] channels;
input [15:0]      select;
output      [63:0] b;


        assign b = ({chansize{select[15]}} & channels[15]) |
                   ({chansize{select[14]}} & channels[14]) |
                   ({chansize{select[13]}} & channels[13]) |
                   ({chansize{select[12]}} & channels[12]) |
                   ({chansize{select[11]}} & channels[11]) |
                   ({chansize{select[10]}} & channels[10]) |
                   ({chansize{select[ 9]}} & channels[ 9]) |
                   ({chansize{select[ 8]}} & channels[ 8]) |
                   ({chansize{select[ 7]}} & channels[ 7]) |
                   ({chansize{select[ 6]}} & channels[ 6]) |
                   ({chansize{select[ 5]}} & channels[ 5]) |
                   ({chansize{select[ 4]}} & channels[ 4]) |
                   ({chansize{select[ 3]}} & channels[ 3]) |
                   ({chansize{select[ 2]}} & channels[ 2]) |
                   ({chansize{select[ 1]}} & channels[ 1]) |
                   ({chansize{select[ 0]}} & channels[ 0]) ;

endmodule


//=================================================================
//
// 2x16 channel Multiplexer for Error Code
//
//=================================================================

module ErrMux(channels, select, b);
parameter chansize=2;
input [15:0][chansize-1:0] channels;
input [15:0]               select;
output      [chansize-1:0] b;


        assign b =  ({chansize{select[15]}} & channels[15]) |
                    ({chansize{select[14]}} & channels[14]) |
                    ({chansize{select[13]}} & channels[13]) |
                    ({chansize{select[12]}} & channels[12]) |
                    ({chansize{select[11]}} & channels[11]) |
                    ({chansize{select[10]}} & channels[10]) |
                    ({chansize{select[ 9]}} & channels[ 9]) |
                    ({chansize{select[ 8]}} & channels[ 8]) |
                    ({chansize{select[ 7]}} & channels[ 7]) |
                    ({chansize{select[ 6]}} & channels[ 6]) |
                    ({chansize{select[ 5]}} & channels[ 5]) |
                    ({chansize{select[ 4]}} & channels[ 4]) |
                    ({chansize{select[ 3]}} & channels[ 3]) |
                    ({chansize{select[ 2]}} & channels[ 2]) |
                    ({chansize{select[ 1]}} & channels[ 1]) |
                    ({chansize{select[ 0]}} & channels[ 0]) ;

endmodule
