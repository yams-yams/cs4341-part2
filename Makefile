all:
	iverilog main.v 2x16Mux.v 4x16Decoder.v 64x16Mux.v DFF.v ArithmeticOps.v LogicOps.v -o Part3
