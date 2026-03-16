module b_decreaser
#(
    parameter WIDTH = 4
)
(
    input logic [WIDTH-1:0] B,
    output logic [WIDTH-1:0] out,
    output logic [3:0] flags
)
    assign out = B - 1;
endmodule