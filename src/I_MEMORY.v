`include "MEM_WB.v"
`include "D_MEM.v"

module I_MEMORY(clock, reset, CTR_bits, alu_result, readdat2, five_bit_muxin, 
                                          CTR_bitsout, Read_dataout, mem_ALU_result, mem_Write_reg);
    input clock, reset;
    input [4:0] CTR_bits, five_bit_muxin;
    input [31:0] alu_result, readdat2;
    
    // Intermediate wires
    wire [31:0] Read_data;
    wire MemWrite;
    wire MemRead;
    
    output [1:0] CTR_bitsout;
    output [31:0] Read_dataout, mem_ALU_result;
    output [4:0] mem_Write_reg; 
    
    assign MemWrite = CTR_bits[2];
    assign MemRead  = CTR_bits[3];
    
    D_MEM data_memory (clock, reset, alu_result, readdat2, MemWrite, MemRead, 
                       Read_data);

    MEM_WB mem_wb_pipeline (clock, reset, CTR_bits[1:0], Read_data, alu_result, five_bit_muxin,
                            CTR_bitsout, Read_dataout, mem_ALU_result, mem_Write_reg);
                            
endmodule
