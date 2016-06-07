`timescale 1ns/1ps
`include "PIPELINE.v"

module testbench();
	reg clock;
	reg reset;
	reg switch;

    wire led;
    
	always begin
		#5 clock = ~clock;
	end

	PIPELINE pipeline1(clock, switch, reset, led);

	initial begin
		reset = 1'b1;
		#5
		reset = 1'b0;
		#5
        clock = 1'b1;
	end

endmodule
