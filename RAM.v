`timescale 1ns/1ns

module RAM(
    input [4:0] DirRam,
    input [31:0] DatosE,
    input WE,
    output reg [31:0] DatosS
);


reg [31:0]mem [0:31];

always @* begin
    DatosS = mem[DirRam];

    if (WE) begin
        if (DirRam >= 0 && DirRam <= 2) begin
            mem[DirRam] = DatosE; // Datos de resta
        end else if (DirRam >= 3 && DirRam <= 5) begin
            mem[DirRam] = DatosE; // Datos de suma
        end else if (DirRam >= 6 && DirRam <= 7) begin
            mem[DirRam] = DatosE; // Otros datos
        end
    end
end

endmodule

