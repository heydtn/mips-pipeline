// Sign extender 16 to 32 bits

module S_EXTEND(IF_ID_instr_immed, signext_out);
  input [15:0] IF_ID_instr_immed;
  output [31:0] signext_out;

  // Repeat most significant bit to pad
  assign signext_out = { {16{IF_ID_instr_immed[15]}}, IF_ID_instr_immed};

endmodule
