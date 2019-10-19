module extend (
	input [15:0]offset,
	output reg [31:0]offset32
);

always @(offset)
begin
 offset32[31:0] = {16'b0000000000000000,offset[15:0]};
end
endmodule
