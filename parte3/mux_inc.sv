module mux_inc (input logic [6:0] q,
                input logic bt1, bt0,
                output logic [6:0] q_out);
    always_comb begin
        if (bt1 ^ bt0) begin
            if (bt0) begin
                q_out = q + 1'b1;
            end else begin
                q_out = q + 4'b1010;
            end
        end else begin
            q_out = q;
        end
    end
endmodule
