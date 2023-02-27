all:
	iverilog main.v 1BitAdd.v 2x16Mux.v 4BitAddSub.v 4x16Decoder.v 4x16Mux.v Divisor.v -o Part2
