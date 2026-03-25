module or_gate
#(
    parameter WIDTH = 4
)
(
    input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,
    output logic [WIDTH-1:0] out,
    output logic N,
    output logic Z,
    output logic V,
    output logic C
);
    assign out = A | B;
    assign Z = (out == 0);
    assign N = out[WIDTH-1];

    assign V = 0;
    assign C = 0;
endmodule