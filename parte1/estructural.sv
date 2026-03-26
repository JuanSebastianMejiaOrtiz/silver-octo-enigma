module estructural
(
    input logic [2:0] in,
    output logic out
);
    logic not_in0, term1, term2;

    not (not_in0, in[0]);
    and (term1, in[1], in[0]);
    and (term2, in[2], not_in0);
    or (out, term1, term2);
endmodule
