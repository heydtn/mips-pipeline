// Module for control bits

module CONTROL(IF_ID_instr, CTR_bits);
  input [5:0] IF_ID_instr;
  output reg [8:0] CTR_bits;
/*
  // R-type instructions
  wire r = (IF_ID_instr == 6'b000000) ? 9'b110000010 : 9'b000000000;

  // Check for load word
  wire lw = (IF_ID_instr == 6'b100011) ? 9'b000101011 : 9'b000000000;

  // Check for store word
  wire sw = (IF_ID_instr == 6'b101011) ? 9'bz0010010z : 9'b000000000;

  // Check for branch
  wire beq = (IF_ID_instr == 6'b000100) ? 9'bz0101000z : 9'b000000000;
  */
    always @(IF_ID_instr) begin
    case (IF_ID_instr)
      6'b000000       : CTR_bits = 9'b110000010;
      6'b100011       : CTR_bits = 9'b000101011;
      6'b101011       : CTR_bits = 9'b000100100; //9'bz0010010z
      6'b000100       : CTR_bits = 9'b001010000; //9'bz0101000z
      6'b100000       : CTR_bits = 9'b000000000; //NOP
      default         : CTR_bits = 9'b000000000;
    endcase
  end

endmodule
