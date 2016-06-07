// Adder for branch target address computation

module ADDER(add_in1, add_in2, add_out);
  input [31:0] add_in1, add_in2;
  output [31:0] add_out;

  assign add_out = add_in1 + add_in2;

endmodule
