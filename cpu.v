module cpu (clk, rst, test, test1);
	input clk, rst;
	output  [31:0]test;
	output [31:0]test1;
	
wire	 [31:0] inst;
wire   [31:0]ctrl, ctrl0, ctrl1, ctrl2;
wire   [20:0]controle;

// wire alu
//wire	 [1:0]ctl;
wire	 [31:0]resultado;

// wire instructionMemory
wire   [31:0]data_out2;

// wire PC
wire   [31:0]pc;

//wire registerFile
wire	 [4:0]addr1, addr2, addr_in;
wire	 [31:0]out1, out2, out3;
wire	 [31:0]in;
wire	 rw;

// wire extend
wire	 [15:0]offset;
wire	 [31:0]offset32;

//wire mux1 
wire   sel1;
wire	 [31:0] imm;
wire   [31:0] data_out1;
wire	 [31:0]address_0;
wire	 [31:0] data_in;
wire	 [31:0]outrg1, outrg2;
wire	 [31:0] M, B, D, D1;

	rom InstructionMemory(
		.address_0(pc),
		.data_out(data_out2)
	);
	
	
	PC PC(
		.rst(rst),
		.clk(clk),
		.pc(pc)
	);
	
ffD FF1(
		.rst(rst),
		.clk(clk),
		.Din(data_out2),
		.Dout(inst)
);
		
	registerFile RegisterFile(
		.addr1(inst[25:21]),
		.addr2(inst[20:16]),
		.out1(outrg1),
		.out2(outrg2),
		.addr_in(ctrl2[4:0]), 
		.in(out2),
		.rst(rst),
		.clk(clk)
	);
	
	control Controlador(
		.instruction(inst),
		.ctrl(controle)
	);
	
	extend Extend(
		.offset(inst[15:0]),
		.offset32(offset32)
	);

	ffD FF2(
		.rst(rst),
		.clk(clk),
		.Din(offset32),
		.Dout(imm)
		);
		
	ffD CONTROLE_0(
		.rst(rst),
		.clk(clk),
		.Din({11'b00000000000, controle[20:0]}),
		.Dout(ctrl0)
		);
	
	//Execute
	mux1 Mux1(
		.Sel(ctrl0[18]),
		.A(outrg2),
		.B(imm),
		.Out(out1)
	);
	
	alu Unidade_logica(
		.ctl(ctrl0[20:19]),
		.a(outrg1),
		.b(out1), 
		.resultado(resultado)
	);
	
	
	mux1 Mux3(
		.Sel(ctrl0[16]),
		.A(D),
		.B(resultado),
		.Out(out3)
	);
	
	
	ffD FF3(
		.rst(rst),
		.clk(clk),
		.Din(resultado),
		.Dout(D)
		);
	
	
	ffD CONTROLE_1(
		.rst(rst),
		.clk(clk),
		.Din(ctrl0),
		.Dout(ctrl1)
		);
	
	//Memory
	data_memory DataMemory(
		.address_0(out3),
		.cs_0(ctrl1[15]),
		.we_0(ctrl0[16]),
		.data_in(outrg2),
		.data_out(M),
		.clk(clk)
	);
	
	ffD FF5(
		.rst(rst),
		.clk(clk),
		.Din(D),
		.Dout(D1)
		);
	
	ffD CONTROLE_2(
		.rst(rst),
		.clk(clk),
		.Din(ctrl1),
		.Dout(ctrl2)
		);
		
	//Write-Back

	mux1 Mux2(
		.Sel(ctrl2[17]),
		.A(D1),
		.B(M),
		.Out(out2)
	);
	
	
	assign test[31:0] = inst[31:0];    //Instruçao 
	
	assign test1[31:0] = out2[31:0];   //Saida do mux 2 (write back)
	
endmodule
