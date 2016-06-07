//combinational mux

module MUX32 (a, b, sel, y);
	input [31:0] a, b;
	input sel;
	
	output [31:0] y;
	
	assign y = sel ? a : b; //if sel == 1, choose a, else b;
endmodule