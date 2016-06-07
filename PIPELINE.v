// Top level pipeline module
`include "I_FETCH.v"

/*
module I_FETCH(clock, reset, EX_MEM_NPC, EX_MEM_PCSrc, IF_ID_IRout, IF_ID_NPCout);
*/

`include "I_DECODE.v"

/*
module I_DECODE(clock, reset, IF_ID_IR, IF_ID_NPC, RegWrite, MEM_WB_Writereg, MEM_WB_Writedata,  // Inputs
                CTR_bitsout, npcout, rdata1out, rdata2out, s_extendout, instrout_2016, instrout_1511);               // Outputs
*/

`include "I_EXECUTE.v"

/*
module I_EXECUTE(clock, reset, CTR_bits, npc, readdat1, readdat2, signext_out, instr_2016, instr_1511,  // Inputs
                 CTR_bitsout, add_result, zero, alu_result, rdata2out, five_bit_muxout);   // Outputs
*/

`include "I_MEMORY.v"

/*
module I_MEMORY(clock, reset, CTR_bits, alu_result, readdat2, five_bit_muxin, CTR_bitsout, Read_dataout, mem_ALU_result, mem_Write_reg);
*/

`include "I_WB.v"

/*
module I_WB(CTR_bits, Read_data, mem_ALU_result, wb_data);
*/

module PIPELINE(clk, switch, reset, led);

  input wire clk, switch, reset;
  //(* dont_touch = "true" *)output wire led;
  
  (* dont_touch = "true" *)output reg led;
  
  
  // switch debounce
  reg [20:0] count;
  reg go, switchnew;

  // Intermediate wires
  wire [31:0] IF_ID_IR, IF_ID_NPC, npcdec, rdata1outdec, rdata2outdec, s_extendoutdec; // DECODE
  wire [31:0] add_resultexec, alu_resultexec, rdata2outexec; // EXECUTE
  wire [31:0] Read_dataoutmem, mem_ALU_result;   // MEM
  wire [8:0] CTR_bitsdec;
  wire [4:0] instrout_2016dec, instrout_1511dec, CTR_bitsexec, five_bit_muxoutexec, MEM_WB_Writereg;
  wire [1:0]  CTR_bitsmem;
  wire zeroexec, RegWrite;

  wire EX_MEM_PCSrc;
  
  wire [31:0] MEM_WB_Writedata;

  I_FETCH instr_fetch (go, reset, add_resultexec, EX_MEM_PCSrc, IF_ID_IR, IF_ID_NPC);  // clock, EX_MEM_NPC, IF_ID_IR, IF_ID_NPC

  // Does this input need to be EX_MEM_NPC instead?  I didn't look into depth into I_FETCH
  // RegWrite MEM_WB_Writereg and MEM_WB_Writedata will be from WB stage, unimplemented as of now
  I_DECODE instr_decode (go, reset, IF_ID_IR, IF_ID_NPC, RegWrite, MEM_WB_Writereg, MEM_WB_Writedata, // Inputs
                         CTR_bitsdec, npcdec, rdata1outdec, rdata2outdec, s_extendoutdec, instrout_2016dec, instrout_1511dec);  // Outputs

  I_EXECUTE instr_execute (go, reset, CTR_bitsdec, npcdec, rdata1outdec, rdata2outdec, s_extendoutdec, instrout_2016dec, instrout_1511dec,  // Inputs
                           CTR_bitsexec, add_resultexec, zeroexec, alu_resultexec, rdata2outexec, five_bit_muxoutexec);
                           
  I_MEMORY instr_memory (go, reset, CTR_bitsexec, alu_resultexec, rdata2outexec, five_bit_muxoutexec, // Inputs
                         CTR_bitsmem, Read_dataoutmem, mem_ALU_result, MEM_WB_Writereg);                 // Outputs
                         
  I_WB instr_writeback (CTR_bitsmem, Read_dataoutmem, mem_ALU_result, MEM_WB_Writedata);
  
  assign RegWrite = CTR_bitsmem[1];

  assign EX_MEM_PCSrc = zeroexec & CTR_bitsexec[4];

  initial begin
    //$monitor ( "Control bits dec = %b  \t NPC = %h \t data1out = %h \ data2out = %h \ s_extendoutdec = %h \ instr2016dec = %b \ instr1511dec = %b " ,
      //        CTR_bitsdec, npcdec, rdata1outdec, rdata2outdec, s_extendoutdec, instrout_2016dec, instrout_1511dec) ;

    //$monitor ( "Control bits exec = %b  \t addres = %h \t zero = %b \ alu result = %h \ rdata2out = %h \ five_bitmux = %b " ,
      //     CTR_bitsexec, add_resultexec, zeroexec, alu_resultexec, rdata2outexec, five_bit_muxoutexec) ;

  end
  
  always @(posedge clk) begin
    if (reset) begin
        led = 0;
    end
    else if (RegWrite) begin
        led = ~led;
    end

    // switch debounce
    if (reset) begin
        switchnew <= switch;
        go <= switch;
        count <= 0;
    end else if (switch != switchnew) begin
        switchnew <= switch;
        count <= 0;
    end else if (count == 600000) begin
        go <= switchnew;
    end else begin
        count <= count + 1;
    end
    
    $display ("Registers: ctr = %b \t RegWrite = %b \t MEMWBreg = %d \t WBdata = %h", CTR_bitsmem, RegWrite, MEM_WB_Writereg, MEM_WB_Writedata);
    //$display ("Writeback: branch address = %h \t PCSrc (0 = C+4) = %b \t NPC = %h", add_resultexec, EX_MEM_PCSrc, IF_ID_NPC);
    //$display ("Memory CTR = %b \t Read datout = %h \t mem alu = %h \t memwb = %h", CTR_bitsmem, Read_dataoutmem, mem_ALU_result, MEM_WB_Writereg);
  end

endmodule
