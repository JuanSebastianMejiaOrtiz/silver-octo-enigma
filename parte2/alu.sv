module alu
#(
    parameter WIDTH = 4
)
(
    input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,
    input logic [3:0] sel,
    output logic [WIDTH-1:0] S,
    output logic N, Z, V, C
);
    logic [WIDTH-1:0] add_out, sub_out, bDecr_out, andGate_out, orGate_out, xorGate_out, bLShift1_out, bLShift2_out;
    logic [3:0] add_flags, sub_flags, bDecr_flags, andGate_flags, orGate_flags, xorGate_flags, bLShift1_flags, bLShift2_flags;

    addition #(.WIDTH(WIDTH)) u_add (
        .A(A), .B(B), .out(add_out),
        .N(add_flags[3]), .Z(add_flags[2]), .V(add_flags[1]), .C(add_flags[0])
    );

    subtraction #(.WIDTH(WIDTH)) u_sub (
        .A(A), .B(B), .out(sub_out),
        .N(sub_flags[3]), .Z(sub_flags[2]), .V(sub_flags[1]), .C(sub_flags[0])
    );

    b_decreaser #(.WIDTH(WIDTH)) u_bDecr (
        .A(A), .B(B), .out(bDecr_out),
        .N(bDecr_flags[3]), .Z(bDecr_flags[2]), .V(bDecr_flags[1]), .C(bDecr_flags[0])
    );

    and_gate #(.WIDTH(WIDTH)) u_andGate (
        .A(A), .B(B), .out(andGate_out),
        .N(andGate_flags[3]), .Z(andGate_flags[2]), .V(andGate_flags[1]), .C(andGate_flags[0])
    );

    or_gate #(.WIDTH(WIDTH)) u_orGate (
        .A(A), .B(B), .out(orGate_out),
        .N(orGate_flags[3]), .Z(orGate_flags[2]), .V(orGate_flags[1]), .C(orGate_flags[0])
    );

    xor_gate #(.WIDTH(WIDTH)) u_xorGate (
        .A(A), .B(B), .out(xorGate_out),
        .N(xorGate_flags[3]), .Z(xorGate_flags[2]), .V(xorGate_flags[1]), .C(xorGate_flags[0])
    );

    b_left_shift_1 #(.WIDTH(WIDTH)) u_bLShift1 (
        .A(A), .B(B), .out(bLShift1_out),
        .N(bLShift1_flags[3]), .Z(bLShift1_flags[2]), .V(bLShift1_flags[1]), .C(bLShift1_flags[0])
    );

    b_left_shift_2 #(.WIDTH(WIDTH)) u_bLShift2 (
        .A(A), .B(B), .out(bLShift2_out),
        .N(bLShift2_flags[3]), .Z(bLShift2_flags[2]), .V(bLShift2_flags[1]), .C(bLShift2_flags[0])
    );

    always_comb begin
        case (sel)
            3'b000: begin
                S = add_out;
                N = add_flags[3]; Z = add_flags[2]; V = add_flags[1]; C = add_flags[0];
            end
            3'b001: begin
                S = sub_out;
                N = sub_flags[3]; Z = sub_flags[2]; V = sub_flags[1]; C = sub_flags[0];
            end
            3'b010: begin
                S = bDecr_out;
                N = bDecr_flags[3]; Z = bDecr_flags[2]; V = bDecr_flags[1]; C = bDecr_flags[0];
            end
            3'b011: begin
                S = andGate_out;
                N = andGate_flags[3]; Z = andGate_flags[2]; V = andGate_flags[1]; C = andGate_flags[0];
            end
            3'b100: begin
                S = orGate_out;
                N = orGate_flags[3]; Z = orGate_flags[2]; V = orGate_flags[1]; C = orGate_flags[0];
            end
            3'b101: begin
                S = xorGate_out;
                N = xorGate_flags[3]; Z = xorGate_flags[2]; V = xorGate_flags[1]; C = xorGate_flags[0];
            end
            3'b110: begin
                S = bLShift1_out;
                N = bLShift1_flags[3]; Z = bLShift1_flags[2]; V = bLShift1_flags[1]; C = bLShift1_flags[0];
            end
            3'b111: begin
                S = bLShift2_out;
                N = bLShift2_flags[3]; Z = bLShift2_flags[2]; V = bLShift2_flags[1]; C = bLShift2_flags[0];
            end
        endcase
    end
endmodule
