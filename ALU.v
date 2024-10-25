`timescale 1ns/1ns

module ALU(

	input [31:0]Ope1,
	input [31:0]Ope2,
	input [2:0]AluOp,
	output reg [31:0]Resultado
);

always @* 
begin
	case (AluOp)
		3'b000: //AND
		begin
			Resultado = Ope1 & Ope2;
		end
		3'b001: //OR
		begin
			Resultado = Ope1 | Ope2;
		end
		3'b010: //SUMA
		begin
			Resultado = Ope1 + Ope2;
		end
		3'b110: //RESTA
		begin
			Resultado = Ope1 - Ope2;
		end
		3'b111: //MAYORQ
		begin
			Resultado = Ope1>Ope2?1:0;
		end
	endcase

end

endmodule


