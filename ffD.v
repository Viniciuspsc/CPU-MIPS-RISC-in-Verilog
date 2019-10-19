module ffD(clk, rst, Din, Dout);

input clk, rst;
input [31:0]Din;
output [31:0]Dout;
reg [31:0]Dout;

always@(posedge clk) 
begin
	if(rst==1)
	Dout <= 0;
	else
	Dout <= Din;
end

endmodule 