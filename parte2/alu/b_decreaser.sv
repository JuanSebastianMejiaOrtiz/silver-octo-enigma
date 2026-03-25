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
    subtraction u_subtraction
    #(
        .WIDTH(WIDTH)
    )
    (
        .A(B),
        .B(1'b1),
        .out(out),
        .N(N),
        .Z(Z),
        .V(V),
        .C(C)
    );
endmodule
