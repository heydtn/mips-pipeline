//MEM/WB pipeline register


module MEM_WB(clock, reset, CTR_bits, Read_data_in, ALU_result_in, Write_reg_in,
                CTR_bitsout, Read_data, mem_ALU_result, mem_Write_reg);
    
    // Input wires
    input clock, reset;
    input [1:0] CTR_bits;
    
    input [31:0] Read_data_in, ALU_result_in;
    input [4:0] Write_reg_in;

    // Storage registers
    (* dont_touch = "true" *)reg [31:0] mem_ALU_result;
    (* dont_touch = "true" *)reg [1:0] CTR_bitsout;
    (* dont_touch = "true" *)reg [4:0] mem_Write_reg;
    
    wire [31:0] Read_data;

    // Output wires
    output [31:0] Read_data, mem_ALU_result;
    output [1:0] CTR_bitsout;
    output [4:0] mem_Write_reg;


    always @(posedge clock or posedge reset) begin
      if (reset) begin
        mem_ALU_result <= 0;
        CTR_bitsout <= 0;
        mem_Write_reg <= 0;
      end
      else begin
        mem_ALU_result <= ALU_result_in;
        CTR_bitsout <= CTR_bits;
        mem_Write_reg <= Write_reg_in;
      end
    end
    
    assign Read_data = Read_data_in;

endmodule
