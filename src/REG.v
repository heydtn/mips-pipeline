// MIPS registers

module REG(clock, IF_ID_instr_rs, IF_ID_instr_rt, RegWrite,
           MEM_WB_Writereg, MEM_WB_Writedata,
           readdat1, readdat2);

  input [4:0] IF_ID_instr_rs, IF_ID_instr_rt, MEM_WB_Writereg;
  input [31:0] MEM_WB_Writedata;

  // Clock wire and toggle to write
  input clock, RegWrite;

  output [31:0] readdat1, readdat2;

  // Initialize 32 registers each 32 bits
  reg [31:0] regs [31:0];
  reg [10:0] i;

  // set outputs as read registers
  assign readdat1 = regs[IF_ID_instr_rs];
  assign readdat2 = regs[IF_ID_instr_rt];

  always @(posedge clock) begin
    if (RegWrite)
      regs[MEM_WB_Writereg] <= MEM_WB_Writedata;
    end  

  // At clock check for write to register
//  always @(posedge clock) begin
//    if (RegWrite)
//      regs[MEM_WB_Writereg] <= MEM_WB_Writedata;
//    end
    
    initial begin
			for (i = 0; i < 32; i = i + 1) begin
				regs[i] = 0;
			end
			
    end

endmodule
