module rom1 
(
    input logic [2:0] addr,
    output logic [3:0] data
);
    logic [3:0] rom [0:7];

    assign data = rom[addr];

    initial begin
        rom[0]  = 4'h2;
        rom[1]  = 4'h7;
        rom[2]  = 4'h6;
        rom[3]  = 4'h0;
        rom[4]  = 4'hF;
        rom[5]  = 4'hA;
        rom[6]  = 4'h8;
        rom[7]  = 4'h9;
    end
endmodule
