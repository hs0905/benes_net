`timescale 1ps/1ps
module tb_network;

parameter CLK_PERIOD = 100; // 100ps

logic clk;
logic [3:0]i_port[0:15];// 4bit * 16 array
logic [3:0]o_port[0:15]; // 4bit * 16 array
logic [7:0]switch_set[0:6]; //8bit * 7 array

network_module DUT(
    .clk(clk), // input clk
    .i_port(i_port), // input i_port
    .o_port(o_port), // output o_port
    .switch_set(switch_set) // input switch_set
);

always begin // clk generator
    #(CLK_PERIOD/2) clk = ~clk; // 50
end

initial begin
    clk = 0;

    #CLK_PERIOD;
    // reset
    foreach(i_port[i])i_port[i] = 4'b0000;
    foreach(switch_set[i])switch_set[i] = 8'b00000000;

    #CLK_PERIOD;
    // set switch_set 
    
    switch_set[0] = 8'b00001111;
    switch_set[1] = 8'b00111100;
    switch_set[2] = 8'b01101001;
    switch_set[3] = 8'b01101001;
    switch_set[4] = 8'b01010101;
    switch_set[5] = 8'b01010101;
    switch_set[6] = 8'b01010101;

/*
    switch_set[0] = 8'b00001111;
    switch_set[1] = 8'b00000000;
    switch_set[2] = 8'b00000000;
    switch_set[3] = 8'b00000000;
    switch_set[4] = 8'b00000000;
    switch_set[5] = 8'b00000000;
    switch_set[6] = 8'b00000000;
*/
    #CLK_PERIOD;
    // set i_port
    foreach(i_port[i])begin // 0~15
        i_port[i] = i; 
    end
    #(CLK_PERIOD*30); // 1ns

    $finish; // end simulation
end

endmodule