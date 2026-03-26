module subtraction
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
    logic [WIDTH-1:0] B_compA2;
    assign B_compA2 = ~B + 1'b1;

    addition #(
        .WIDTH(WIDTH)
    ) u_addition (
        .A(A),
        .B(B_compA2),
        .out(out),
        .N(N),
        .Z(Z),
        .V(V),
        .C(C)
    );
endmodule

module substraction_tb();
    localparam delay = 10ns;

    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] S;
    logic N, Z, V, C;
    logic [4:0] i, j;

    logic carry;
    logic [3:0] B_compA2;

    logic [3:0] S_esp;
    logic N_esp, Z_esp, V_esp, C_esp;

    substraction u_substraction(
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
        B_compA2 = ~B + 4'b0001;

        {carry, S_esp} = A + B_compA2;
        C_esp = carry;
        V_esp = A[3]&B_compA2[3]&~S_esp[3] | ~A[3]&~B_compA2[3]&S_esp[3];

        if(S_esp == 0) begin
            Z_esp = 1'b1;
        end else begin
            Z_esp = 1'b0;
        end
        if(S_esp > 4'b1000) begin
            N_esp = 1'b1;
        end else begin
            N_esp = 1'b0;
        end
    end
endmodule

