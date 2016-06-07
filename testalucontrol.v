// File name : test alucontrol . v
// Description: Testing the ALU control module of the EX stage of the pipeline.

`include "ALU_CONTROL.v"

module test ( ) ;
  // Wire Ports
  wire [ 2 : 0 ] select;
  // Register Declarations
  reg [ 1 : 0 ] alu_op ;
  reg [ 5 : 0 ] funct ;
  ALU_CONTROL alucontrol1 ( alu_op, funct, select ) ;
  initial begin
    alu_op = 2'b00 ;
    funct = 6'b100000 ;
    $monitor ( "ALUOp = %b \ tfunct = %b\ tselect = %b ", alu_op , funct , select) ;
    #10
    alu_op = 2'b01 ;
    funct = 6'b100000 ;
    #10
    alu_op = 2'b10 ;
    funct = 6'b100000 ;
    #10
    funct = 6'b100010 ;
    #10
    funct = 6'b100100 ;
    #10
    funct = 6'b100101 ;
    #10
    funct = 6'b101010 ;
    #10
    alu_op = 2'b11;
    funct = 6'b101100 ;
    #10
    $finish ;
  end
endmodule // test
