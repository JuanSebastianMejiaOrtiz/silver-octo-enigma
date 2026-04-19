module Deco (
    input  logic [3:0] S,   
    output logic [6:0] DISP,    
);
	 logic [3:0] d,u;


    always_comb begin
        case (S)
            4'h0: DISP0 = 7'b1000000; // 0
            4'h1: DISP0 = 7'b1111001; // 1
            4'h2: DISP0 = 7'b0100100; // 2
            4'h3: DISP0 = 7'b0110000; // 3
            4'h4: DISP0 = 7'b0011001; // 4
            4'h5: DISP0 = 7'b0010010; // 5
            4'h6: DISP0 = 7'b0000010; // 6
            4'h7: DISP0 = 7'b1111000; // 7
            4'h8: DISP0 = 7'b0000000; // 8
            4'h9: DISP0 = 7'b0011000; // 9
            default: DISP0 = 7'b1111111; // Apagado por defecto
        endcase
    end
endmodule

module Deco_tb();
    localparam delay = 10ns;

    logic [3:0] q;
    logic [6:0] disp;

    Deco displays_u (
        .S(q), .DISP(disp)
    );

    initial begin
        for (q = 0; q < 16; q++) begin
            $display("Display %h", disp);
            #delay;
        end
        $stop;
    end
endmodule

