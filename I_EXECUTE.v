// Module instruction execute

`include "ADDER.v"
`include "ALU.v"
`include "ALU_CONTROL.v"
`include "EX_MEM.v"
`include "MUX32.v"
`include "MUX5.v"

module I_EXECUTE(clock, reset, CTR_bits, npc, readdat1, readdat2, signext_out, instr_2016, instr_1511,  // Inputs
                 CTR_bitsout, add_result, zero, alu_result, rdata2out, five_bit_muxout);   // Outputs

  // Inputs
  input clock, reset;
  input [8:0] CTR_bits;
  input [31:0] npc, readdat1, readdat2, signext_out;
  input [4:0] instr_2016, instr_1511;

  // Outputs
  output [4:0] CTR_bitsout, five_bit_muxout;
  output [31:0] add_result, alu_result, rdata2out;
  output zero;

  // Intermediate wires
  wire [31:0] addout, mux32_out, aluout;
  wire [4:0] mux5_out;
  wire [2:0] select;
  wire zeroout;

  ADDER adder1 (npc, signext_out, addout);                           // Exports addout

  MUX32 alumux (signext_out, readdat2, CTR_bits[5], mux32_out );     // Exports mux32_out

  ALU_CONTROL alucontrol (CTR_bits[7:6], signext_out[5:0], select);  // Exports select

  ALU alu1 (readdat1, mux32_out, select, zeroout, aluout);           // Imports select/mux32_out, exports zeroout/aluout

  MUX5 mux1 (instr_1511, instr_2016, CTR_bits[8], mux5_out);         // Exports mux5_out

  EX_MEM ex_mem_pipeline (clock, reset, CTR_bits[4:0], addout, zeroout, aluout, readdat2, mux5_out,        // Imports addout, zeroout, aluout, mux5_out
                          CTR_bitsout, add_result, zero, alu_result, rdata2out, five_bit_muxout);

endmodule
