// Pipeline register ID_EX

module ID_EX(clock, reset, CTR_bits, npc,        // Input clock, control bits, and npc
             readdat1, readdat2, signext_out,                  // Input data1 and data2 and sign extended immed
             instr_2016, instr_1511,          // Input IFID_instr[20-16] and [15-11]
             CTR_bitsout, npcout, rdata1out, rdata2out, s_extendout, instrout_2016, instrout_1511); // Outputs

  // Define inputs
  input clock, reset;
  input [8:0] CTR_bits;                                         // 9-bit control bits
  input [31:0] readdat1, readdat2, signext_out, npc;            // Input 32 bit data values, npc
  input [4:0] instr_2016, instr_1511;

  // Define outputs
  output [8:0] CTR_bitsout;
  output [31:0] npcout, rdata1out, rdata2out, s_extendout;
  output [4:0] instrout_2016, instrout_1511;


  // Storage register definitions
  (* dont_touch = "true" *)reg [8:0] CTR_bitsout;
  (* dont_touch = "true" *)reg [31:0] rdata1out, rdata2out, s_extendout, npcout;
  (* dont_touch = "true" *)reg [4:0] instrout_2016, instrout_1511;



  always @(posedge clock or posedge reset) begin
    if (reset) begin
      CTR_bitsout <= 0;
      npcout <= 0;
      rdata1out <= 0;
      rdata2out <= 0;
      s_extendout <= 0;
      instrout_2016 <= 0;
      instrout_1511 <= 0;
    end
    else begin
      CTR_bitsout <= CTR_bits;
      npcout <= npc;
      rdata1out <= readdat1;
      rdata2out <= readdat2;
      s_extendout <= signext_out;
      instrout_2016 <= instr_2016;
      instrout_1511 <= instr_1511;
    end
  end

endmodule
