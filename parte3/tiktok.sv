module tiktok(input logic btpress1, btpress2, swt, rst, clkfpga,
    output logic [6:0] dispU, dispD
);
    logic btu, btd, clk;
    logic [6:0] q;

    pulse pulseU_u (
        .clk(clkfpga), .reset(rst), .pulse(btu)
    );
    pulse pulseD_u (
        .clk(clkfpga), .reset(rst), .pulse(btd)
    );
    
    cntdiv_n clockDivisor_u (
        .clk(clkfpga), .rst(rst), .clkout(clk)
    );

    timer timer_u (
        .q(q), .clk(clk), .en(en), .rst(rst), .q_out(q),
        .bt1(btd), .bt0(btu)
    );

    Deco displays_u (
        .S(q), .DISP0(dispU), .DISP1(dispD)
    );
endmodule

module tiktok_tb();
endmodule
