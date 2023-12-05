module stage_module(
    input logic clk,
    input logic [7:0]switch_set, // 8bit
    input logic [3:0]i_port[15:0], // 4bit * 16vector
    output logic [3:0]o_port[15:0] // 4bit * 16vector
    );

generate
    for(genvar i=0; i<8; i=i++) begin:switch_instance
        
    switch_module s(
        .clk(clk),
        .switch_set(switch_set[i]),
        .i_port(i_port[i*2+1:i*2][3:0]),
        .o_port(o_port[i*2+1:i*2][3:0])
    );
    end
endgenerate

endmodule

