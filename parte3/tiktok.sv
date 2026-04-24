module tiktok #(parameter TOPVAL=50_000_000) (
    input logic btU, btT, en, rst, clk,
    output logic [6:0] disp0, disp1,
    output logic led
);
    logic [3:0] qUnits, qTens;

    timer #(.TOPVAL(TOPVAL)) timer_u (
        .btT(btT), .btU(btU), .rst(rst), .en(en), .clk(clk),
        .qOutUnits(qUnits), .qOutTens(qTens)
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
    localparam CLK_PERIOD = 20ns;
    localparam CYCLES = 4;

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

    task automatic decreaserWait(input int times);
        repeat (times * CYCLES) begin
            @(posedge clk);
            $display("Display Unidades %h, Decenas %h", disp0, disp1);
        end
    endtask

    task automatic buttonPress(ref logic btn, input int times);
        repeat (times) begin
            @(negedge clk);
            btn = 1'b1;
            @(posedge clk);
            @(negedge clk);
            btn = 1'b0;
            @(posedge clk);
            $display("After press: Units=%h, Tens=%h", disp0, disp1);
        end
    endtask

    initial clk = 1'b0;
    always #(CLK_PERIOD / 2) clk = ~clk;

    initial begin
        // Reset
        btU = 0; btT = 0; en = 0; led = 0;
        rst = 1;
        @(posedge clk);
        // rst = 0;
        @(posedge clk);
		  rst = 0;
		  @(posedge clk);

        // Configure to 11
        buttonPress(btU, 1);
        buttonPress(btT, 1);
        $display("After config: Units=%h, Tens=%h", disp0, disp1);

        // Timer mode – count down 5 seconds
        en = 1;
        decreaserWait(5);
        
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

/*
module tiktok #(parameter TOPVAL=50_000_000) (
    input logic btU, btT, en, rst, clk,
    output logic [6:0] disp0, disp1,
    output logic led
);
    logic [3:0] qUnits, qTens;
    logic [3:0] qOutUnits, qOutTens;

    timer #(.TOPVAL(TOPVAL)) timer_u (
        .btT(btT), .btU(btU), .rst(rst), .en(en), .clk(clk),
        .qUnits(qUnits), .qTens(qTens),
        .qOutUnits(qOutUnits), .qOutTens(qOutTens)
    );

    Deco decoDispUnits_u (
        .S(qUnits), .DISP(disp0)
    );

    Deco decoDispTens_u (
        .S(qTens), .DISP(disp1)
    );

    assign led = (qUnits == 4'b0000) & (qTens == 4'b0000);

    always_ff @(posedge clk) begin
        qUnits <= qOutUnits;
        qTens <= qOutTens;
    end
endmodule
*/
