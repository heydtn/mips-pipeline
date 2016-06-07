`include "MUX32.v"

module I_WB(CTR_bits, Read_data, mem_ALU_result, wb_data);
    input [1:0] CTR_bits;
    input [31:0] Read_data, mem_ALU_result;

    wire [31:0] wb_data;
    wire MemToReg;
    
    assign MemToReg = CTR_bits[0];
    
    output [31:0] wb_data;

    MUX32 muxwb (Read_data, mem_ALU_result, MemToReg, wb_data);
endmodule
