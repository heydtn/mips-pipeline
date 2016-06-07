//incrementer by 4 (to select the next word from the PC)

module incr_4 (pcout, pcin);
	input [31:0] pcin;
	output [31:0] pcout;
	
	assign pcout = pcin + 3'd1;
endmodule