module flujo_datos
(
    input logic [2:0] in,
    output logic out
);
    assign out = (in[2] & ~in[0]) | (in[1] & in[0]);
endmodule