`timescale 1ps/1ps

module tb_network;

parameter CLK_PERIOD = 10; // 100 MHz => 10 ns

logic clk;
logic [3:0]i_port[7:0];// 8 ports, each port has 4 bits
logic [3:0]o_port[7:0];// 8 ports, each port has 4 bits
logic [3:0]switch_set[4:0];// 5 switches, each switch has 4 bits

always begin // clock generator
    clk = 0;
    #5;
    clk = 1;
    #5;
end

network_module dut(
    .clk(clk),
    .i_port(i_port),
    .o_port(o_port),
    .switch_set(switch_set) // 5 switches, each switch has 4 bits
);

initial begin

    foreach(i_port[i]) i_port[i] = 4'b0000; // initialize all ports to 0
    foreach(o_port[i]) o_port[i] = 4'b0000; // initialize all ports to 0
    foreach(switch_set[i]) switch_set[i] = 4'b0000; // initialize all switches to 0

    #CLK_PERIOD; // wait for 1 clock cycle

    // set switch 0 to 0b0001
    switch_set[0] = 4'b0010; // bar bar cross bar
    switch_set[1] = 4'b0110; // bar cross cross bar
    switch_set[2] = 4'b0110;// bar cross cross bar
    switch_set[3] = 4'b0101;// bar cross bar cross
    switch_set[4] = 4'b0101;// bar cross bar cross

    #CLK_PERIOD; // wait for 1 clock cycle

    // set i_port 0 to 0b0001

    for(int i= 0; i<8; i=i+1) begin 
        i_port[i] = i; 
    end

    #100; // wait for 1 clock cycle

    $finish;

end

endmodule
