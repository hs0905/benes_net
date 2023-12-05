module stage_module(
    input logic clk,
    input logic [7:0]switch_set, // 8bit
    input logic [3:0]i_port[0:15], // 4bit * 16vector
    output logic [3:0]o_port[0:15] // 4bit * 16vector
    );


generate
    for(genvar i=0; i<8; i++) begin:switch_instance
    switch_module s(
        .clk(clk),
        .switch_set(switch_set[i]),
        .i_port_0(i_port[2*i]),
        .i_port_1(i_port[2*i+1]),
        .o_port_0(o_port[2*i]),
        .o_port_1(o_port[2*i+1])
    );
    end
endgenerate

endmodule

