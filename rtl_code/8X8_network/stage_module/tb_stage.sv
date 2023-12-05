`timescale 1ps/1ps

module tb_stage;

logic clk;
logic [3:0]i_port[7:0];
logic [3:0]o_port[7:0];
logic [3:0]switch_set;

always begin //clock_generator period is 20

#10 clk = ~clk;

end

stage_module DUT(
    .clk(clk),
    .switch_set(switch_set),
    .i_port(i_port),
    .o_port(o_port)
);

initial begin
    clk = 0;

    #20
    foreach(i_port[i])begin
       i_port[i] = 4'b0000; 
    end

    foreach(o_port[i])begin
        o_port[i] = 4'b0000;
    end

    switch_set = 4'b0000;

    #40 //set the switch_set
    switch_set = 4'b0101;


    #40 // inject the i_port port_num
    foreach(i_port[i])begin
        i_port[i] = i;
    end

    #80
    $finish;
end


endmodule