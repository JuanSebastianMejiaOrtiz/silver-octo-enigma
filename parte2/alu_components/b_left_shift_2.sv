module b_left_shift_2
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
    logic [1:0] carry;

    assign {carry, out} = {B, 2'b00};
    assign C = carry[0];
    assign Z = (out == 0);
    assign N = out[WIDTH-1];

    assign V = 0;
endmodule