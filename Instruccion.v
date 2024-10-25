`timescale 1ns/1ns

module ISA(
	input [19:0]instruccion,
	output [31:0]Salida
);

wire [31:0] d1BR_op1Alu;
wire [31:0] d2BR_op2Alu;
wire [31:0] DatosE_RAM;
wire [31:0] DatosS_RAM;

Banco instBanco (
	.DL1(instruccion[19:15]), 
	.DL2(instruccion[14:10]),
	.DE(0),
	.Dato(0),
	.WE(instruccion[9]),
	.op1(d1BR_op1Alu),
	.op2(d2BR_op2Alu)
);

ALU instAlu(
	.Ope1(d1BR_op1Alu),
	.Ope2(d2BR_op2Alu),
	.AluOp(instruccion[8:6]),
	.Resultado(Salida)
);

RAM instRam (
	.DirRam(instruccion[5:1]),
    .DatosE(DatosE_RAM),
    .WE(instruccion[0]),
    .DatosS(Salida)
);


endmodule

