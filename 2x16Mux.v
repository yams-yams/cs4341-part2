//-------------------------------------------------
//
// Sample Multiplexer Circuit
// Eric William Becker
// September 25, 2022
//
// For my students this semester.
//
//-------------------------------------------------



//=================================================================
//
// 8-bit, 16 channel Multiplexer
//
//=================================================================

module ErrMux(channels, select, b);
parameter chansize=2;
input [15:0][chansize-1:0] channels;
input [15:0]               select;
output      [chansize-1:0] b;


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

