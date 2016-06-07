// File ename : test alu.v
// Description: Testing module for the ALU
module test ( ) ;

  //// Register Declarations
  reg [ 31 : 0 ] A,B ;
  reg [ 2 : 0 ] control ;
  // Wire Ports
  wire [ 31 : 0 ] result;
  wire zero ;

  ALU alu1 (A,B,control,zero,result);
  initial begin
    A <= 32'b1010 ;
    B <= 32'b0111 ;
    control <= 3'b011 ;
    $display ( " A = %b \ B = %b " , A, B) ;
    $monitor ( " ALUOp = %b \ tresult = %b \ zero = %b " , control , result, zero ) ;
    #1
    control <= 3'b100 ;
    #1
    control <= 3'b010 ;
    #1
    control <= 3'b111 ;
    #1
    control <= 3'b011 ;
    #1
    control <= 3'b110 ;
    #1
    control <= 3'b001 ;
    #1
    control <= 3'b000 ;
    #1
    $finish ;
  end

endmodule // t e s t
