module timer #(
    parameter TOPVAL = 50_000_000
) (
    input logic clk, en, rst, btU, btT,
    output logic [3:0] qOutUnits, qOutTens
);
    // Registros internos para la cuenta actual
    logic [3:0] curUnits, curTens;
    
    // Senales de tick (1 ciclo cada TOPVAL ciclos de clk)
    logic tick;
    logic clkdiv;
    
    // Pulsos de los botones (flanco positivo)
    logic btU_pulse, btT_pulse;
    
    // Divisor de reloj para generar tick de 1 Hz
    cntdiv_n #(.TOPVALUE(TOPVAL)) clockDivider (
        .clk(clk), .clkout(clkdiv), .rst(rst)
    );
    
    // Generar un pulso de un ciclo a partir de clkdiv (flanco positivo)
    logic clkdiv_prev;
    always_ff @(posedge clk or posedge rst) begin
        if (rst) clkdiv_prev <= 1'b0;
        else clkdiv_prev <= clkdiv;
    end
    assign tick = clkdiv && !clkdiv_prev;
    
    // Deteccion de flanco para los botones usando pulse.sv
    pulse pulseU (
        .clk(clk),
        .reset(rst),
        .d(btU),
        .pulse(btU_pulse)
    );
    
    pulse pulseT (
        .clk(clk),
        .reset(rst),
        .d(btT),
        .pulse(btT_pulse)
    );
    
    // Logica principal de cuenta (actualizacion en cada flanco de clk)
    always_ff @(posedge clk) begin
        if (rst) begin
            curUnits <= 4'd0;
            curTens  <= 4'd0;
        end else begin
            if (en) begin
                // Modo temporizador: decrementar cuando tick = 1
                if (tick) begin
                    if (curUnits != 4'd0) begin
                        curUnits <= curUnits - 4'd1;
                    end else if (curTens != 4'd0) begin
                        curTens  <= curTens - 4'd1;
                        curUnits <= 4'd9;
                    end
                    // si ambos son 0, se queda en 0
                end
            end else if (btU_pulse ^ btT_pulse) begin
                // Modo configuracion: incrementar con los pulsos de los botones
                if (btU_pulse) begin
                    if (curUnits == 4'd9) curUnits <= 4'd0;
                    else curUnits <= curUnits + 4'd1;
                end
                if (btT_pulse) begin
                    if (curTens == 4'd9) curTens <= 4'd0;
                    else curTens <= curTens + 4'd1;
                end
            end
        end
    end
    
    // Salidas
    assign qOutUnits = curUnits;
    assign qOutTens  = curTens;
endmodule

