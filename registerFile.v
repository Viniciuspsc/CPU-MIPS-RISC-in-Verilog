module registerFile(addr1,addr2,out1,out2,addr_in,in,clk,rst);

input [4:0] addr1;	
input [4:0] addr2;	
output [31:0] out1;	
output [31:0] out2;	
input [4:0] addr_in;	
input [31:0] in;	
reg [31:0] out1;
reg [31:0] out2;
input clk, rst;
integer i;
reg [31:0] regmem [15:0];

always @(posedge clk)
begin
		out1 <= regmem[addr1];
		out2 <= regmem[addr2];
end

	always@ (negedge clk or posedge rst)
	if(rst)
	begin 
	for(i = 0;i<16;i=i+1)
	begin
	regmem [i]=32'b0;
	end
	end
		else 
		begin
		 regmem[addr_in] <= in;
		end

endmodule
