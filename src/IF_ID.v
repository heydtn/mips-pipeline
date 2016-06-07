// IF/ID pipeline register

module IF_ID (clock, reset, IF_ID_IR, IF_ID_NPC, IF_ID_IRout, IF_ID_NPCout);

    // Input wires
    input clock, reset;
    input [31:0] IF_ID_IR, IF_ID_NPC;

    // Storage registers
    (* dont_touch = "true" *)reg [31:0] IF_ID_IRout, IF_ID_NPCout;

    // Output wires
    output [31:0] IF_ID_IRout, IF_ID_NPCout;


    always @(posedge clock or posedge reset) begin
      if (reset) begin
        IF_ID_IRout <= 32'h80000000;
        IF_ID_NPCout <= 0;
      end
      else begin
        IF_ID_IRout <= IF_ID_IR;
        IF_ID_NPCout <= IF_ID_NPC;
      end
    end

endmodule
