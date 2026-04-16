module addition
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

    assign {carry, out} = A + B;
    assign C = carry;
    assign V = A[WIDTH-1]&B[WIDTH-1]&~out[WIDTH-1] | ~A[WIDTH-1]&~B[WIDTH-1]&out[WIDTH-1];
    assign Z = (out == 0);
    assign N = out[WIDTH-1];
endmodule

module addition_tb();
    localparam delay = 10ns;
    localparam WIDTH = 4;

    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] S;
    logic N, Z, V, C;
    logic [4:0] i, j;

    logic carry;

    logic [3:0] S_esp;
    logic N_esp, Z_esp, V_esp, C_esp;

    addition u_addition(
        .A(A),
        .B(B),
        .out(S),
        .N(N),
        .Z(Z),
        .V(V),
        .C(C)
    );

    initial begin
        A = 4'b0;
        B = 4'b0;

        i = 5'b0;
        #delay
        for (i=0; i<=15; i++) begin
            A = i[3:0];
            j = 5'b0;
            for (j=0; j <= 15; j++) begin
                B = j[3:0];
                #delay;
                if (S == S_esp) begin
                    $display("OK: S esperado: %h, S salida: %h", S_esp, S);
                end else begin
                    $display("ERROR: S esperado: %h, S salida: %h", S_esp, S);
                end
                #delay;
            end
            #delay;
        end
        $stop;
    end

    always_comb begin
        {carry, S_esp} = A + B;
        C_esp = carry;
        V_esp = A[WIDTH-1]&B[WIDTH-1]&~S_esp[WIDTH-1] | ~A[WIDTH-1]&~B[WIDTH-1]&S_esp[WIDTH-1];
        Z_esp = (S_esp == 0);
        N_esp = S_esp[WIDTH-1];
    end
endmodule
