//instruction memory

module imem(data, addr);
	input [6:0] addr;
	output [31:0] data;
	
	reg [31:0] MEM [0:127];
	
	reg [20:0] i;
	
	assign data = MEM[addr];
	
	initial begin
	   $readmemb("imem.bin",MEM);
	   $display ("Initializing instruction memory...");
	   for (i = 0; i < 20; i = i + 1) begin
	       $display ("%4d:%b", i, MEM[i]);
	   end
	end
		//initialize memory
/*		MEM[0] <= 32'h002300AA; // slt  $0, $1, $3
		MEM[4] <= 32'h10654321; //beq   $3, $5, offset=17185
		MEM[8] <= 32'h80000000; //NOP
		MEM[12] <= 32'h00100022; //sub $0, $0, $16	 
		MEM[16] <= 32'h8C123456; // lw    $18, 13398($0) 
		MEM[20] <= 32'h80000000; //NOP 
		MEM[24] <= 32'h80000000; //NOP
		MEM[28] <= 32'h8F123456; 
		MEM[32] <= 32'hAD654321; 
		MEM[36] <= 32'h13012345; 
		MEM[40] <= 32'hAC654321; 
		MEM[44] <= 32'h12012345;*/


endmodule
