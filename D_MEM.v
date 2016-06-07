//data memory

module D_MEM(clock, reset, Address, Write_data, MemWrite, MemRead,  // Inputs
             Read_data);                                            // Outputs
    input clock, reset;
    input [31:0] Address, Write_data;
    input MemWrite, MemRead;
    output wire [31:0] Read_data;
    
    reg [31:0] dmem [0:255];
    
    reg [31:0] dmem_data;
    
    //wire [24:0] addr;
    
    //assign addr = Address[24:0];
    
    always@ (posedge clock or posedge reset) begin
            if (MemWrite) begin
                dmem[Address] = Write_data;
            end
            if (MemRead) begin
                dmem_data = dmem[Address];
            end
            if (reset) begin
                dmem_data = 0;
            end
    end
            
	
	assign Read_data = MemWrite ? Write_data : dmem_data;
	
	initial begin
	   $readmemh("dmem.hex",dmem);
    end
	   
/*            dmem[0] = 32'hA00000AA; 
            dmem[1] = 32'h10000011; 
            dmem[2] = 32'h20000022; 
            dmem[3] = 32'h30000033; 
            dmem[4] = 32'h40000044; 
            dmem[5] = 32'h50000055; 
            dmem[6] = 32'h60000066; 
            dmem[7] = 32'h70000077; 
            dmem[8] = 32'h80000088;
            dmem[9] = 32'h90000099;
			dmem[10] = 32'hA00000AA; 
            dmem[11] = 32'h10000011; 
            dmem[12] = 32'h20000022; 
            dmem[13] = 32'h30000033; 
            dmem[14] = 32'h40000044; 
            dmem[15] = 32'h50000055; 
            dmem[16] = 32'h60000066; 
            dmem[17] = 32'h70000077; 
            dmem[18] = 32'h80000088;
            dmem[19] = 32'h90000099;
			dmem[20] = 32'hA00000AA; 
            dmem[21] = 32'h10000011; 
            dmem[22] = 32'h20000022; 
            dmem[23] = 32'h30000033; 
            dmem[24] = 32'h40000044; 
            dmem[25] = 32'h50000055; 
            dmem[26] = 32'h60000066; 
            dmem[27] = 32'h70000077; 
            dmem[28] = 32'h80000088;
            dmem[29] = 32'h90000099;
			dmem[30] = 32'hA00000AA; 
            dmem[31] = 32'h10000011;*/
 
    
endmodule
