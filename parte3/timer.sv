module timer #(TOPVAL = 50_000_000) (
    input logic [3:0] qUnits, qTens,
    input logic clk, en, rst, btU, btT,
    output logic [3:0] qOutUnits, qOutTens
);
    logic [3:0] qDecUnits, qDecTens, qIncUnits, qIncTens;
    logic d, clkdiv, btUPulse, btTPulse;

    cntdiv_n #(.TOPVALUE(TOPVAL)) clockDivider_u (
        .clk(clk), .clkout(clkdiv), .rst(rst)
    );

    pulse getUnitsPulse (
        .clk(clk), .reset(rst), .d(btU),
        .pulse(btUPulse)
    );

    pulse getTensPulse (
        .clk(clk), .reset(rst), .d(btT),
        .pulse(btTPulse)
    );

    enum bit [3:0] {
        S0, S1, S2, S3, S4, S5, S6, S7, S8, S9,
        SErr = 4'b1111
    } states;

    always_ff @(posedge clk) begin
        if (rst == 1'b1) begin
            qIncUnits <= S0;
            qIncTens <= S0;
        end else begin
            if (btUPulse == 1'b1) begin
                case (qUnits) begin
                    S0: qIncUnits <= S1;
                    S1: qIncUnits <= S2;
                    S2: qIncUnits <= S3;
                    S3: qIncUnits <= S4;
                    S4: qIncUnits <= S5;
                    S5: qIncUnits <= S6;
                    S6: qIncUnits <= S7;
                    S7: qIncUnits <= S8;
                    S8: qIncUnits <= S9;
                    S9: qIncUnits <= S0;
                    default: qIncUnits <= SErr;
                endcase
            end else begin
                qIncUnits <= qUnits;
            end

            if (btTPulse == 1'b1) begin
                case (qTens) begin
                    S0: qIncTens <= S1;
                    S1: qIncTens <= S2;
                    S2: qIncTens <= S3;
                    S3: qIncTens <= S4;
                    S4: qIncTens <= S5;
                    S5: qIncTens <= S6;
                    S6: qIncTens <= S7;
                    S7: qIncTens <= S8;
                    S8: qIncTens <= S9;
                    S9: qIncTens <= S0;
                    default: qIncTens <= SErr;
                endcase
            end else begin
                qIncTens <= qTens;
            end
        end
    end

    always_ff @(posedge clkdiv) begin
        if (rst) begin
            qDecUnits <= S0;
            qDecTens <= S0;
        end else begin
            case (qTens) begin
                S0: begin
                    qDecTens <= S0;
                    D <= 1'b1;
                end
                S1: begin
                    qDecTens <= S0;
                    D <= 1'b0;
                end
                S2: begin
                    qDecTens <= S1;
                    D <= 1'b0;
                end
                S3: begin
                    qDecTens <= S2;
                    D <= 1'b0;
                end
                S4: begin
                    qDecTens <= S3;
                    D <= 1'b0;
                end
                S5: begin
                    qDecTens <= S4;
                    D <= 1'b0;
                end
                S6: begin
                    qDecTens <= S5;
                    D <= 1'b0;
                end
                S7: begin
                    qDecTens <= S6;
                    D <= 1'b0;
                end
                S8: begin
                    qDecTens <= S7;
                    D <= 1'b0;
                end
                S9: begin
                    qDecTens <= S8;
                    D <= 1'b0;
                end
                default: begin
                    qDecTens <= SErr;
                    D <= 1'b1;
                end
            endcase

            if (D == 1'b0) begin
                case (qUnits) begin
                    S0: qDecUnits <= S9;
                    S1: qDecUnits <= S0;
                    S2: qDecUnits <= S1;
                    S3: qDecUnits <= S2;
                    S4: qDecUnits <= S3;
                    S5: qDecUnits <= S4;
                    S6: qDecUnits <= S5;
                    S7: qDecUnits <= S6;
                    S8: qDecUnits <= S7;
                    S9: qDecUnits <= S8;
                    default: qDecUnits <= SErr;
                endcase
            end else begin
                case (qUnits) begin
                    S0: qDecUnits <= S0;
                    S1: qDecUnits <= S0;
                    S2: qDecUnits <= S1;
                    S3: qDecUnits <= S2;
                    S4: qDecUnits <= S3;
                    S5: qDecUnits <= S4;
                    S6: qDecUnits <= S5;
                    S7: qDecUnits <= S6;
                    S8: qDecUnits <= S7;
                    S9: qDecUnits <= S8;
                    default: qDecUnits <= SErr;
                endcase
            end
        end
    end
    
    always_comb begin
        if (en == 1'b1) begin
            qOutUnits = qDecUnits;
            qOutTens = qDecTens;
        end else begin
            qOutUnits = qIncUnits;
            qOutTens = qIncTens;
        end
    end
endmodule
