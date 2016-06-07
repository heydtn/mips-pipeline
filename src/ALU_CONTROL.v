module ALU_CONTROL(alu_op, funct, select);
  input [1:0] alu_op;
  input [5:0] funct;
  output reg [2:0] select;

  always @(alu_op or funct) begin
    case (alu_op)
      2'b00       : select = 3'b010;
      2'b01       : select = 3'b110;
      2'b10       : begin case(funct)
                      6'b100000 : select = 3'b010;
                      6'b100010 : select = 3'b110;
                      6'b100100 : select = 3'b000;
                      6'b100101 : select = 3'b001;
                      6'b101010 : select = 3'b111;
                      default : select = 3'bxxx;
                     endcase
                    end
      2'b11       : select = 3'bxxx;
    endcase
    $display ("Operation: aluop= %b \t funct=%b \t select=%b",alu_op,funct,select);
  end

endmodule
