module b_decreaser
#(
    parameter WIDTH = 4
)
(
    input logic [WIDTH-1:0] B,
    output logic [WIDTH-1:0] out,
    output logic N,
    output logic Z,
    output logic V,
    output logic C
)
    assign out = B - 1;
endmodule
