module Deco (
    input  logic [6:0] S,   
    output logic [6:0] DISP0,    
    output logic [6:0] DISP1
);
	 logic [3:0] d,u;

	 /*
	 always_comb begin
			flag = S > 99;
			d = S / 10;
			u = S - 10*d;
			
		  if (S > 99) begin
				// No se puede poner asi
				// Input no se puede modificar de esta manera
				// Mirar a ver como se haria esto
            // S = 7'b1100011;
				d = 4'b1001;
				u = 4'b1001;
				
				// Idea es usar este flag y ver si con esto se cambia dato
				flag = 1'b1;
		  end else begin
				d = S / 10;
				u = S - 10*d;
		  
				if (S > 90) begin
					d = 4'b1001;
				end
				else if (S > 80) begin
					d = 4'b1000;
				end
				else if (S > 70) begin
					d = 4'b0111;
				end
				else if (S > 60) begin
					d = 4'b0110;
				end
				else if (S > 50) begin
					d = 4'b0101;
				end
				else if (S > 40) begin
					d = 4'b0100;
				end
				else if (S > 30) begin
					d = 4'b0011;
				end
				else if (S > 20) begin
					d = 4'b0010;
				end
				else if (S > 10) begin
					d = 4'b0001;
				end
				else begin
					d = 4'b0000;
				end
				
		  end
	 end
	 */

    always_comb begin
			d = S / 10;
			u = S - 10*d;
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
				default: DISP0 = 7'b1;
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












