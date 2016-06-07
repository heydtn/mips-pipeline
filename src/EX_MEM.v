// Pipeline register EX_MEM

module EX_MEM(clock, reset, CTR_bits,                           // Input clock, control bits
             adder_out, aluzero, aluout, readdat2, muxout,      // Inputs from EX stage
             CTR_bitsout, add_result, zero, alu_result, rdata2out, five_bit_muxout);  // Outputs

  // Define inputs
  input clock, reset;
  input [31:0] adder_out, aluout, readdat2;            // Input 32 bit data values, npc
  input [4:0] CTR_bits, muxout;
  input aluzero;

  // Define outputs
  output [4:0] CTR_bitsout, five_bit_muxout;
  output [31:0] add_result, alu_result, rdata2out;
  output zero;

  // Storage register definitions
  (* dont_touch = "true" *)reg [4:0] CTR_bitsout;
  (* dont_touch = "true" *)reg [31:0] add_result, alu_result, rdata2out;
  (* dont_touch = "true" *)reg [4:0] five_bit_muxout;
  (* dont_touch = "true" *)reg zero;

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      CTR_bitsout <= 0;
      add_result <= 0;
      alu_result <= 0;
      rdata2out <= 0;
      five_bit_muxout <= 0;
      zero <= 0;
    end
    else begin
      CTR_bitsout <= CTR_bits;
      add_result <= adder_out;
      alu_result <= aluout;
      rdata2out <= readdat2;
      five_bit_muxout <= muxout;
      zero <= aluzero;
    end
  end

endmodule
