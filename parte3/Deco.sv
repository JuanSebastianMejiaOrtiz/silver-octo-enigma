module modulo_dec (
    input  logic [6:0] S,   
    output logic [6:0] DISP0,    
    output logic [6:0] DISP1     
);
	 logic [3:0] d,u;

	 always_comb begin
		  if (S > 7'b1100011) begin
                S = 7'b1100011;
		  end else if (S >= 10) begin
				d = S / 10;
				u = S - d*10;
		  end
	 end

    always_comb begin
        case (u)
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
        endcase
        case (d)
            4'h0: DISP1 = 7'b1000000; // 0
            4'h1: DISP1 = 7'b1111001; // 1
            4'h2: DISP1 = 7'b0100100; // 2
            4'h3: DISP1 = 7'b0110000; // 3
            4'h4: DISP1 = 7'b0011001; // 4
            4'h5: DISP1 = 7'b0010010; // 5
            4'h6: DISP1 = 7'b0000010; // 6
            4'h7: DISP1 = 7'b1111000; // 7
            4'h8: DISP1 = 7'b0000000; // 8
            4'h9: DISP1 = 7'b0011000; // 9
            default: DISP1 = 7'b1111111; // Apagado por defecto
        endcase
    end
endmodule












