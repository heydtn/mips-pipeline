module ALU(a, b, control, zero, result);
  input [31:0] a, b;    // Input values
  input [2:0] control;  // From ALU Control
  output zero;
  output [31:0] result;


  assign result = (control == 3'b010) ? a + b :   // add
                  (control == 3'b110) ? a - b :   // subtract
                  (control == 3'b000) ? a & b :   // and
                  (control == 3'b001) ? a | b :   // or
                  (control == 3'b111) ? ((a < b) ? 32'b1 : 32'b0) : // Check for less than, if so output appropriately
                   {32{1'bx}};  // If none of these are triggered, there is an incorrect operation, output unknown

  assign zero = (result == 32'b0) ? 1'b1 : 1'b0;

endmodule
