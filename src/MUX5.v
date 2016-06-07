// Mux 2 input (5 bit wide) 1 output (5 bit wide)

module MUX5(a, b, sel, y);
  input [4:0] a, b;
  input sel;
  output [4:0] y;

  assign y = (sel) ? a : b;

endmodule
