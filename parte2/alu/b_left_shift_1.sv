module b_left_shift_1
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
    logic carry;

    assign {carry, out} = {B, 1'b0};
    assign C = carry;
    assign Z = (out == 0);
    assign N = out[WIDTH-1];

    assign V = 0;
endmodule