module top_system (
    input  logic [3:0] A,
    input  logic [2:0] ADDR,
    input  logic [2:0] SEL,

    output logic [6:0] DISP0, 
    output logic [6:0] DISP1,  
    output logic N,           
    output logic Z,    
    output logic C,    
    output logic V      
);

    logic [3:0] B_interno; 
    logic [3:0] S_interno;

    rom1 u_rom (
        .addr(ADDR),
        .data(B_interno)
    );


    alu u_alu (
        .A(A),
        .B(B_interno),
        .sel(SEL),
        .S(S_interno),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V)
    );

    Deco u_dec (
        .S(S_interno),
        .SEL(SEL),
        .DISP0(DISP0),
        .DISP1(DISP1)
    );

endmodule

