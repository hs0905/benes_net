`timescale 1ps/1ps
module tb_network;

parameter CLK_PERIOD = 100; // 10 MHz = 100 ns

logic clk;
logic [3:0]i_port[7:0];
logic [3:0]o_port[7:0];
logic [3:0]switch_set[4:0];

network_module DUT(
    .clk(clk),
    .i_port(i_port),
    .o_port(o_port),
    .switch_set(switch_set)
);

always begin // clk generator
    #(CLK_PERIOD/2) clk = ~clk;
end

initial begin
    clk = 0;

    #CLK_PERIOD;
    // reset
    foreach(i_port[i])i_port[i] = 4'b0000;
    foreach(o_port[i])o_port[i] = 4'b0000;
    foreach(switch_set[i])switch_set[i] = 4'b0000;

    #CLK_PERIOD;
    // 0 = bar, 1 = cross
    switch_set[0] = 4'b1111; // bar bar cross bar
    switch_set[1] = 4'b1101; // bar cross cross bar
    switch_set[2] = 4'b1001; // bar cross cross barW
    switch_set[3] = 4'b0101; // bar cross bar cross
    switch_set[4] = 4'b0101; // bar cross bar cross

    #CLK_PERIOD;
    // set the i_port with 0, 1, 2, 3, 4, 5, 6, 7
    foreach(i_port[i])begin
    i_port[i] = 7-i;
    end

    #10000;
    
    $finish;
    
end

endmodule