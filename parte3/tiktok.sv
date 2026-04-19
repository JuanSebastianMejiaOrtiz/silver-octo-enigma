module tiktok(
    input logic btU, btT, en, rst, clk,
    output logic [6:0] disp0, disp1,
    output logic led
);
    logic [3:0] qUnits, qTens;

    timer timer_u (
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

// TODO:
// Hacer el testbench de esta vaina
// Pensar bien como seria las pruebas para que quede bien
module tiktok_tb();
endmodule
