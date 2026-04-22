module tiktok #(TOPVAL=50_000_000) (
    input logic btU, btT, en, rst, clk,
    output logic [6:0] disp0, disp1,
    output logic led
);
    logic [3:0] qUnits, qTens;

    timer #(.TOPVAL(TOPVAL)) timer_u (
        .btT(btT), .btU(btU), .rst(rst), .en(en),
        .qUnits(qUnits), .qTens(qTens),
        .qOutUnits(qUnits), .qTens(qTens)
    );

    Deco decoDispUnits_u (
        .S(qUnits), .DISP(disp0)
    );

    Deco decoDispTens_u (
        .S(qTens), .DISP(disp1)
    );

    assign led = (qUnits == 4'b0000) & (qTens == 4'b0000);
endmodule

module tiktok_tb();
    localparam DELAY_DEF = 10ns;
    localparam CYCLES = 5;

    // Inputs
    logic btU, btT, en, rst, clk;
    // Outputs
    logic [6:0] disp0, disp1;
    logic led;
    // Counter

    tiktok #(.TOPVAL(CYCLES)) titoc_u (
        .btU(btU), .btT(btT), .en(en), .rst(rst), .clk(clk),
        .led(led), .disp0(disp0), .disp1(disp1)
    );

    task decreaserWait(input int times, input time delay = DELAY_DEF);
        int i;
        for (i = 0; i <= times * CYCLES; i++) begin
            clk = 1'b1;
            #delay;
            clk = 1'b0;
            #delay;
            $display("Display Unidades %h", disp0);
            $display("Display Decenas %h\n", disp1);
        end
    endtask

    task buttonPress(ref logic btn, input int times, input time delay = DELAY_DEF);
        int i;
        for (i = 0; i < times; i++) begin
            btn = 1'b1;
            clk = 1'b1;
            #delay;
            btn = 1'b0;
            clk = 1'b0;
            #delay;
            $display("Display Unidades %h", disp0);
            $display("Display Decenas %h\n", disp1);
        end
    endtask

    initial begin
        // Primero reset y se presiona una vez cada boton para tener 11
        btU = 1'b0;
        btT = 1'b0;
        en = 1'b0;
        rst = 1'b1;
        clk = 1'b1;
        #DELAY_DEF;

        btU = 1'b1;
        clk = 1'b0;
        #DELAY_DEF;
        $display("Display Unidades %h", disp0);
        $display("Display Decenas %h\n", disp1);

        btU = 1'b0;
        btT = 1'b1;
        clk = 1'b1;
        #DELAY_DEF;

        btT = 1'b0;
        clk = 1'b0;
        #DELAY_DEF;
        $display("Display Unidades %h", disp0);
        $display("Display Decenas %h\n", disp1);

        // Modo timer
        en = 1'b1;
        // Reduccion de 5 segundos
        decreaserWait(5);

        // Modo config
        en = 1'b0;
        // 10 veces boton unidades para que de la vuelta sin cambiar de valor
        buttonPress(btU, 10);
        // 2 veces boton decenas
        buttonPress(btT, 2);

        // Modo timer
        en = 1'b1;
        // Que vaya hasta 0 y se quede ahi un momentico
        decreaserWait(40);

        // Modo config
        en = 1'b0;
        // 11 veces boton decenas para ver que gire bien
        buttonPress(btT, 11);

        // Modo timer
        en = 1'b1;
        // Que vaya hasta 0 y se quede ahi un momentico, otra vez
        decreaserWait(40);

        // Modo config
        en = 1'b0;
        // 19 veces boton unidades para que de la vuelta sin cambiar de valor
        buttonPress(btU, 19);
        // 19 veces boton decenas para lo mismo
        buttonPress(btT, 19);

        // Modo timer
        en = 1'b1;
        // Que vaya hasta 0 y se quede ahi un momentico
        decreaserWait(110);

        $stop;
    end
endmodule
