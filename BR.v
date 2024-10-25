`timescale 1ns/1ns

//Definición del módulo
module Banco(
	input [4:0]DL1,
	input [4:0]DL2,
	input [4:0]DE,
	input [31:0]Dato,
	input WE,
	output reg [31:0]op1,
	output reg [31:0]op2
);

//Dfinir (mem) registro bidimencional
reg [31:0]BR [0:31];

always @* 
begin
	if(WE)
	begin
		BR[DE]=Dato;
	end

	op1 = BR[DL1];
	op2 = BR[DL2];

end

endmodule

