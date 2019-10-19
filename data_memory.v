module data_memory(
clk , 
address_0 , 

data_in , 
data_out,
cs_0 , 
we_0 
);
parameter data_0_WIDTH = 32 ;
parameter ADDR_WIDTH = 13 ;
input [ADDR_WIDTH-1:0] address_0 ;

input cs_0 ;
input we_0 ;
input clk;
input [data_0_WIDTH-1:0] data_in ;
output reg [data_0_WIDTH-1:0] data_out;
reg [data_0_WIDTH-1:0] mem [ADDR_WIDTH-1:0];

initial
begin
$readmemb("DataMemory.txt", mem);
end

always @ (posedge clk)
begin : MEM_WRITE
if ( cs_0 && we_0 ) begin
mem[address_0] <= data_in;
end
end

	always @ (posedge clk)
		begin : MEM_READ_0
			if (cs_0 && !we_0 ) begin
				data_out <= mem[address_0];
			end else begin
				data_out <= 0;
		end
	end
endmodule
