module adition
#(
    parameter WIDTH = 4
)
(
    input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,
    output logic [WIDTH-1:0] out,
    output logic [3:0] flags
)
    assign out = A + B;
endmodule