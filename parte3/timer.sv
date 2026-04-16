module timer(input logic [6:0] q,
            input logic clk, en, rst, bt1, bt0, flag,
            output logic [6:0] q_out,
				output logic flag_out
);
    logic [6:0] q_inc;

    mux_inc u_inc (
        .q(q), .bt1(bt1), .bt0(bt0), .q_out(q_inc)
    );
	 
	 assign flag_out = q > 99;
    
    always_ff @(posedge clk) begin
        if (rst) begin
            q_out <= 7'b0;
        end
        else if (en) begin
            q_out <= q - 1'b1;
        end
		  else if (flag) begin
            q_out <= 7'b1100011;
        end
		  else begin
				q_out <= q_inc;
		  end
    end
endmodule

module timer_tb();
    localparam delay = 500ns;

    logic [6:0] q;
    logic clk, en, rst, bt1, bt0;

    logic [6:0] q_esp, d, q_inc;

    logic [7:0] i;

    mux_inc u_inc (
        .q(q_esp), .bt1(bt1), .bt0(bt0), .q_out(q_inc)
    );

    timer u_timer (
        .q(q), .clk(clk), .en(en), .rst(rst), .bt1(bt1), .bt0(bt0),
        .q_out(q)
    );

    initial begin
        i = 0;

        rst = 1'b1;
        clk = 1'b1;
        #delay;
        clk = 1'b0;
        #delay;

        rst = 1'b0;
        en = 1'b1;

        for (i=0; q > 0; i++) begin
            clk = 1'b1;
            #delay;
            clk = 1'b0;
            #delay;
            if (q == q_esp) begin
                $display("OK: Q esperado: %h, Q salida: %h", q_esp, q);
            end else begin
                $display("ERROR: Q esperado: %h, Q salida: %h", q_esp, q);
            end
        end
        $stop;
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            q_esp <= 7'b0;
        end
        else if (en) begin
            q_esp <= q_esp - 1;
        end else begin
            q_esp <= q_inc;
        end
    end
endmodule
