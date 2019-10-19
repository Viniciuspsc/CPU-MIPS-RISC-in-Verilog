module rom(

address_0 , 
data_out , 
);
parameter data_0_WIDTH = 32 ;
parameter ADDR_WIDTH = 100 ;

input [6:0] address_0 ;
output[data_0_WIDTH-1:0] data_out ;
reg [data_0_WIDTH-1:0] mem [ADDR_WIDTH-1:0];

initial
begin
$readmemb("InstructionMemory.txt", mem);
end


assign data_out = mem[address_0];

endmodule
