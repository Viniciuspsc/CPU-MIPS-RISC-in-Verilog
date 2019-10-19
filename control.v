module control(instruction, ctrl);
    input [31:0] instruction;
	 output [20:0] ctrl;
    reg    [20:0] ctrl;
	 wire [11:0] opcode;
	 wire [4:0] rs, rt, rd;
	
    parameter LW = 12'b000111_xxxxxx;
    parameter SW = 12'b001000_xxxxxx;
    parameter ADD = 12'b000110_100000;
	 parameter SUB = 12'b000110_100010;
	 parameter AND = 12'b000110_100100;
	 parameter OR = 12'b000110_100101;
	 
	 assign opcode[11:0] = {instruction[31:26], instruction[5:0]};
	 assign rs[4:0] = {instruction[25:21]};
	 assign rt[4:0] = {instruction[20:16]};
	 assign rd[4:0] = {instruction[15:11]};
	 
    always @(instruction)
    begin
        casex (opcode)
          LW :
          begin
              ctrl[20:0]={6'b10_1_1_0_1,rs[4:0],5'b00000,rt[4:0]};
          end
          SW :
          begin
              ctrl[20:0]={6'b10_1_1_1_1,rs[4:0],5'b00000,rt[4:0]};
          end
          ADD :
          begin
              ctrl[20:0]={6'b10_0_0_0_1,rs[4:0],rt[4:0],rd[4:0]};
          end
          SUB :
          begin
              ctrl[20:0]={6'b11_0_0_0_1,rs[4:0],rt[4:0],rd[4:0]};
          end
          AND :
          begin
              ctrl[20:0]={6'b00_0_0_0_1,rs[4:0],rt[4:0],rd[4:0]};
          end
			 OR :
          begin
              ctrl[20:0]={6'b01_0_0_0_1,rs[4:0],rt[4:0],rd[4:0]};
          end
          default
          begin
              ctrl[20:0]={21'b0}; 
          end
        endcase
    end
endmodule
