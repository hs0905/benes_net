`timescale 1ns / 1ps

parameter clock_period = 10;

module tb_stage;

logic clk;
logic [3:0]i_port[15:0];
logic [3:0]o_port[15:0];
logic [7:0]switch_set;

stage_module DUT(
    .clk(clk),
    .i_port(i_port),
    .o_port(o_port),
    .switch_set(switch_set)
);

//clock generator
always begin
    #(clock_period/2) clk = ~clk;
end

initial begin
clk = 0;

#clock_period;
//initial port&switch_set
switch_set = 8'b00000000;
foreach(i_port[i])i_port[i] = 4'b0000;
foreach(o_port[i])o_port[i] = 4'b0000;

#clock_period;
foreach(i_port[i])begin
    i_port[i] = 15-i;
end

#clock_period;
switch_set = 8'b01010101;

#(clock_period*2);

$finish;

end

endmodule