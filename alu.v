module alu(ctl, a, b, resultado);
  input [1:0] ctl;
  input [31:0] a, b;
  output reg [31:0] resultado;

  always @(*)
  begin
    case (ctl)
      2'b00 : resultado = a & b; // and
      2'b01 : resultado = a | b; // or
      2'b10 : resultado = a + b; // somar
      2'b11 : resultado = a - b; // subtrair
      default : resultado = 32'hxxxxxxxx;
   endcase
	
 end
endmodule
