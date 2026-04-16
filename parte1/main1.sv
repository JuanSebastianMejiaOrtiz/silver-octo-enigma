module main1
(
    input logic [2:0] in,
    output logic out
);
    logic [2:0] i_outs;
    flujo_datos u_flujo (
        .in(in),
        .out(i_outs[0])
    );
    comportamental u_comportamental (
        .in(in),
        .out(i_outs[1])
    );
    estructural u_estructural (
        .in(in),
        .out(i_outs[2])
    );

    assign out = i_outs[0] & i_outs[1] & i_outs[2];
endmodule
