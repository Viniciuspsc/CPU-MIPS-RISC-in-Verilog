module PC(
 
  input rst,
  input clk,
  output reg [31:0]pc
  );

	always @(posedge clk or posedge rst)
		if (rst == 1)
		pc = 0;
		
		else if(pc < 19)
				pc = pc + 1;
				else
				pc = 19;
  endmodule
