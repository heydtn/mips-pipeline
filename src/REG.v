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
            /*regs[0] = 32'hA00000AA; 
            regs[1] = 32'h10000011; 
            regs[2] = 32'h20000022; 
            regs[3] = 32'h30000033; 
            regs[4] = 32'h40000044; 
            regs[5] = 32'h50000055; 
            regs[6] = 32'h60000066; 
            regs[7] = 32'h70000077; 
            regs[8] = 32'h80000088;
            regs[9] = 32'h90000099;
			regs[10] = 32'hA00000AA; 
            regs[11] = 32'h10000011; 
            regs[12] = 32'h20000022; 
            regs[13] = 32'h30000033; 
            regs[14] = 32'h40000044; 
            regs[15] = 32'h50000055; 
            regs[16] = 32'h60000066; 
            regs[17] = 32'h70000077; 
            regs[18] = 32'h80000088;
            regs[19] = 32'h90000099;
			regs[20] = 32'hA00000AA; 
            regs[21] = 32'h10000011; 
            regs[22] = 32'h20000022; 
            regs[23] = 32'h30000033; 
            regs[24] = 32'h40000044; 
            regs[25] = 32'h50000055; 
            regs[26] = 32'h60000066; 
            regs[27] = 32'h70000077; 
            regs[28] = 32'h80000088;
            regs[29] = 32'h90000099;
			regs[30] = 32'hA00000AA; 
            regs[31] = 32'h10000011; */
			for (i = 0; i < 32; i = i + 1) begin
				regs[i] = 0;
			end
			
    end

endmodule
