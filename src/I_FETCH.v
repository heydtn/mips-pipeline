//instruction fetch

`include "incr_4.v"
`include "MUX32.v"
`include "imem.v"
`include "IF_ID.v"

module I_FETCH(clock, reset, EX_MEM_NPC, EX_MEM_PCSrc, IF_ID_IRout, IF_ID_NPCout);

	// Input wires
	input clock, reset;
	input [31:0] EX_MEM_NPC;
	input EX_MEM_PCSrc;

    // Output wires
	(* dont_touch = "true" *)output [31:0] IF_ID_IRout, IF_ID_NPCout;

	(* dont_touch = "true" *)reg [31:0] PC;

    // Intermediate wires
	wire [31:0] IF_ID_NPC;
	wire [6:0] addr;
	wire [31:0] add;
	wire [31:0] IF_ID_IR;  // previous name: data

	 //we only need the first 7 bits to span 128 memory slots.
	 //this step isn't necessary.
	assign addr = PC[6:0];

	//read the instruction at the address in the PC.
	imem imem1 (IF_ID_IR, addr);

	 //move to the next instruction by incrementing the PC by 4 (next word).
	incr_4 incr1 (add, PC);

	//choose either to branch to the PC+4 or some other branch (specified by an instruction).
	//for this assignment, PC_CHOOSE is always 0, so PC->PC+4.
	MUX32 mux1 (EX_MEM_NPC, add, EX_MEM_PCSrc, IF_ID_NPC);

	IF_ID if_id_pipeline (clock, reset, IF_ID_IR, IF_ID_NPC, IF_ID_IRout, IF_ID_NPCout);

    always @(posedge clock or posedge reset) begin
				if (reset) begin
					PC <= 0;
			  end
				else begin
        	PC = IF_ID_NPC;
				end
    end

endmodule
