// Module instruction decode

`include "CONTROL.v"
`include "ID_EX.v"
`include "REG.v"
`include "S_EXTEND.v"

module I_DECODE(clock, reset, IF_ID_IR, IF_ID_NPC, RegWrite, MEM_WB_Writereg, MEM_WB_Writedata,  // Inputs
                CTR_bitsout, npcout, rdata1out, rdata2out, s_extendout, instrout_2016, instrout_1511);               // Outputs
  input clock, reset;
  input [31:0] IF_ID_IR, IF_ID_NPC, MEM_WB_Writedata;
  input [4:0] MEM_WB_Writereg;
  input RegWrite;

  // Instruction parts
  wire [5:0] opcode;                // Opcode portion of the instruction
  wire [4:0] rs, rt;                 // Registers from instruction
  wire [15:0] immed;                 // Immediate value from instruction
  wire [4:0] instr_2016, instr_1511; // Instruction chunks

  //wire [31:0] readdat1, readdat2, s_extended;  // Data read from registers, and sign extended immediate

  // Output wires
  output [8:0] CTR_bitsout;
  output [31:0] npcout, rdata1out, rdata2out, s_extendout;
  output [4:0] instrout_2016, instrout_1511;

  // Split the input instruction into its components
  assign opcode = IF_ID_IR[31:26];
  assign rs = IF_ID_IR[25:21];
  assign rt = IF_ID_IR[20:16];
  assign immed = IF_ID_IR[15:0];
  assign instr_2016 = IF_ID_IR[20:16];
  assign instr_1511 = IF_ID_IR[15:11];

  // Intermediate wires
  wire [8:0] CTR_bits;
  wire [31:0] readdat1, readdat2, s_extended;

  // Instantiate control, feed it the opcode
  CONTROL control1 (opcode, CTR_bits);

  REG reg1 (clock, rs, rt, RegWrite, MEM_WB_Writereg, MEM_WB_Writedata, readdat1, readdat2);

  S_EXTEND s_extender (immed, s_extended);

  ID_EX id_ex_pipeline (clock, reset, CTR_bits, IF_ID_NPC, readdat1, readdat2, s_extended, instr_2016, instr_1511, // Inputs
                        CTR_bitsout, npcout, rdata1out, rdata2out, s_extendout, instrout_2016, instrout_1511); // Outputs

endmodule
