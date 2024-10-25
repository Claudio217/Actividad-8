`timescale 1ns/1ns

module TB_RAM;

    reg [4:0] DirRam;
    reg [31:0] DatosE;
    reg WE;
    wire [31:0] DatosS;

    reg [4:0] DL1;
    reg [4:0] DL2;
    reg [4:0] DE;
    reg [31:0] Dato;
    reg WE_BR;
    wire [31:0] op1;
    wire [31:0] op2;

    reg [31:0] Ope1;
    reg [31:0] Ope2;
    reg [2:0] AluOp;
    wire [31:0] Resultado;

    // Instancia RAM
    RAM ram_inst (
        .DirRam(DirRam),
        .DatosE(DatosE),
        .WE(WE),
        .DatosS(DatosS)
    );

    // Instancia del Banco de Registros
    Banco br_inst (
        .DL1(DL1),
        .DL2(DL2),
        .DE(DE),
        .Dato(Dato),
        .WE(WE_BR),
        .op1(op1),
        .op2(op2)
    );

    // Instancia de la ALU
    ALU alu_inst (
        .Ope1(Ope1),
        .Ope2(Ope2),
        .AluOp(AluOp),
        .Resultado(Resultado)
    );

    initial begin
        // Caso 1: Resta
        // Almacenar valores de resta en RAM
        DirRam = 5'b00000; // Dirección 0 en RAM
        DatosE = 32'd30;   // Primer operando (30)
        WE = 1;            // Habilitar escritura
        #10;
        WE = 0;            // Deshabilitar escritura
        #10;

        DirRam = 5'b00001; // Dirección 1 en RAM
        DatosE = 32'd10;   // Segundo operando (10)
        WE = 1;            // Habilitar escritura
        #10;
        WE = 0;            // Deshabilitar escritura
        #10;

        // Almacenar los valores en el Banco de Registros
        DE = 5'b00000;     // Dirección de escritura en BR
        Dato = 32'd30;     // Dato (30)
        WE_BR = 1;        // Habilitar escritura en BR
        #10;
        WE_BR = 0;        // Deshabilitar escritura
        #10;

        DE = 5'b00001;     // Dirección de escritura en BR
        Dato = 32'd10;     // Dato (10)
        WE_BR = 1;        // Habilitar escritura en BR
        #10;
        WE_BR = 0;        // Deshabilitar escritura
        #10;

        // Leer los datos del Banco de Registros para realizar la resta
        DL1 = 5'b00000; // Leer el primer operando
        DL2 = 5'b00001; // Leer el segundo operando
        #10;

        Ope1 = op1;    // Cargar el primer operando
        Ope2 = op2;    // Cargar el segundo operando
        AluOp = 3'b110; // Operación de resta
        #10;

        $display("Resta: %d - %d = %d", Ope1, Ope2, Resultado);

        #100;

        // Caso 2: Suma
        // Almacenar valores de suma en RAM
        DirRam = 5'b00011; // Dirección 3 en RAM
        DatosE = 32'd20;   // Primer operando (20)
        WE = 1;            // Habilitar escritura
        #10;
        WE = 0;            // Deshabilitar escritura
        #10;

        DirRam = 5'b00100; // Dirección 4 en RAM
        DatosE = 32'd15;   // Segundo operando (15)
        WE = 1;            // Habilitar escritura
        #10;
        WE = 0;            // Deshabilitar escritura
        #10;

        // Almacenar los valores en el Banco de Registros
        DE = 5'b00010;     // Dirección de escritura en BR
        Dato = 32'd20;     // Dato (20)
        WE_BR = 1;        // Habilitar escritura en BR
        #10;
        WE_BR = 0;        // Deshabilitar escritura
        #10;

        DE = 5'b00011;     // Dirección de escritura en BR
        Dato = 32'd15;     // Dato (15)
        WE_BR = 1;        // Habilitar escritura en BR
        #10;
        WE_BR = 0;        // Deshabilitar escritura
        #10;

        // Leer los datos del Banco de Registros para realizar la suma
        DL1 = 5'b00010; // Leer el primer operando
        DL2 = 5'b00011; // Leer el segundo operando
        #10;

        Ope1 = op1;    // Cargar el primer operando
        Ope2 = op2;    // Cargar el segundo operando
        AluOp = 3'b010; // Operación de suma
        #10;

        $display("Suma: %d + %d = %d", Ope1, Ope2, Resultado);


        #100;

        // Caso 3: Operación AND
        // Almacenar valores para la operación AND en RAM
        DirRam = 5'b00110; // Dirección 6 en RAM
        DatosE = 32'd5;    // Primer operando (5)
        WE = 1;            // Habilitar escritura
        #10;
        WE = 0;            // Deshabilitar escritura
        #10;

        DirRam = 5'b00111; // Dirección 7 en RAM
        DatosE = 32'd3;    // Segundo operando (3)
        WE = 1;            // Habilitar escritura
        #10;
        WE = 0;            // Deshabilitar escritura
        #10;

        // Almacenar los valores en el Banco de Registros
        DE = 5'b00100;     // Dirección de escritura en BR
        Dato = 32'd5;      // Dato (5)
        WE_BR = 1;        // Habilitar escritura en BR
        #10;
        WE_BR = 0;        // Deshabilitar escritura
        #10;

        DE = 5'b00101;     // Dirección de escritura en BR
        Dato = 32'd3;      // Dato (3)
        WE_BR = 1;        // Habilitar escritura en BR
        #10;
        WE_BR = 0;        // Deshabilitar escritura
        #10;

        // Leer los datos del Banco de Registros para realizar la operación AND
        DL1 = 5'b00100; // Leer el primer operando
        DL2 = 5'b00101; // Leer el segundo operando
        #10;

        Ope1 = op1;    // Cargar el primer operando
        Ope2 = op2;    // Cargar el segundo operando
        AluOp = 3'b000; // Operación AND
        #10;

        $display("AND: %d AND %d = %d", Ope1, Ope2, Resultado);

        #100;
        $stop;
    end
endmodule
