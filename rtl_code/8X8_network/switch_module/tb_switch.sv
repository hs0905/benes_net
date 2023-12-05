`timescale 1ps/1ps

module tb_switch;

logic clk;
logic [3:0]i_port0;
logic [3:0]i_port1;
logic [3:0]o_port0;
logic [3:0]o_port1;
logic switch_set;

always begin //clock_generator period is 20

#10 clk = ~clk;

end

switch_module DUT(
    .clk(clk),
    .i_port_0(i_port0),
    .i_port_1(i_port1),
    .o_port_0(o_port0),
    .o_port_1(o_port1),
    .switch_set(switch_set)
);

initial begin

    clk = 0;

    #10
    i_port0 = 4'b0000;
    i_port1 = 4'b0000;
    o_port0 = 4'b0000;
    o_port1 = 4'b0000;
    switch_set = 4'b0000;    

    #20
    switch_set = 4'b0001; 

    #20
    i_port0 = 4'b0010;
    i_port1 = 4'b0000;

    #100 $finish;
end
endmodule


