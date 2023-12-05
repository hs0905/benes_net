module stage_module(
    input logic [3:0]i_port[7:0],
    output logic [3:0]o_port[7:0],
    input logic clk,
    input [0:3]switch_set
    );

    generate
        for(genvar i = 0; i<4; i=i+1) begin : switch_instance

        switch_module s(
            .i_port_0(i_port[2*i+1]),
            .i_port_1(i_port[2*i]),
            .clk(clk),
            .switch_set(switch_set[i]),
            .o_port_0(o_port[2*i+1]),
            .o_port_1(o_port[2*i])
        );
        end
    endgenerate

endmodule