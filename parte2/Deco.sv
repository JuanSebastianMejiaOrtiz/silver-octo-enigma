module modulo_dec (
    input  logic [3:0] S,   
    input  logic [2:0] SEL,      
    output logic [6:0] DISP0,    
    output logic [6:0] DISP1     
);

    logic is_arith;
    logic [3:0] magnitud;
    logic [3:0] valor_a_mostrar;

    assign is_arith = (SEL == 3'b000 || SEL == 3'b001 || SEL == 3'b010);


    always_comb begin
        if (is_arith && S[3]) begin
            magnitud = ~S + 4'b0001; 
        end else begin
            magnitud = S;
        end
    end

    assign valor_a_mostrar = is_arith ? magnitud : S;

    always_comb begin
        case (valor_a_mostrar)
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
            4'hA: DISP0 = 7'b0001000; // A
            4'hB: DISP0 = 7'b0000011; // b
            4'hC: DISP0 = 7'b1000110; // C
            4'hD: DISP0 = 7'b0100001; // d
            4'hE: DISP0 = 7'b0000110; // E
            4'hF: DISP0 = 7'b0001110; // F
            default: DISP0 = 7'b1111111; // Apagado por defecto
        endcase
    end
	 
    always_comb begin
        if (is_arith && S[3]) begin
            DISP1 = 7'b0111111; 
        end else begin
            DISP1 = 7'b1111111; 
        end
    end

endmodule












