module mux1 (
		input [31:0] A, B,
		input Sel,
		output reg [31:0] Out
	);

	always @(Sel, A, B) begin
		case (Sel)
			0: Out = A;
			1:	Out = B;
		endcase
	end

endmodule
	
	
	