module network_module(
    input logic [3:0]i_port[7:0], // 8 ports 
    input logic clk, // clock
    input logic [3:0]switch_set[4:0], // 5 switches
    output logic [3:0]o_port[7:0] // 8 ports
);

logic [3:0]stage_0_reg[7:0];
logic [3:0]stage_1_reg[7:0];
logic [3:0]stage_2_reg[7:0];
logic [3:0]stage_3_reg[7:0];

logic [3:0]stage_1_input[7:0];
logic [3:0]stage_2_input[7:0];
logic [3:0]stage_3_input[7:0];
logic [3:0]stage_4_input[7:0];

always_ff@(posedge clk) begin : stage_path
    stage_1_input = {
        stage_0_reg[7],
        stage_0_reg[5],
        stage_0_reg[3],
        stage_0_reg[1],
        stage_0_reg[6],
        stage_0_reg[4],
        stage_0_reg[2],
        stage_0_reg[0]
    };

    stage_2_input = {
        stage_1_reg[7],
        stage_1_reg[5],
        stage_1_reg[6],
        stage_1_reg[4],
        stage_1_reg[3],
        stage_1_reg[1],
        stage_1_reg[2],
        stage_1_reg[0]
    };
    
    stage_3_input = {
        stage_2_reg[7],
        stage_2_reg[5],
        stage_2_reg[6],
        stage_2_reg[4],
        stage_2_reg[3],
        stage_2_reg[1],
        stage_2_reg[2],
        stage_2_reg[0]
    };
    
    stage_4_input = {
        stage_3_reg[7],
        stage_3_reg[3],
        stage_3_reg[6],
        stage_3_reg[2],
        stage_3_reg[5],
        stage_3_reg[1],
        stage_3_reg[4],
        stage_3_reg[0]
    };
end

stage_module stage0(
    .i_port(i_port),
    .clk(clk),
    .o_port(stage_0_reg),
    .switch_set(switch_set[0])
);

stage_module stage1(
    .i_port(stage_1_input),
    .clk(clk),
    .o_port(stage_1_reg),
    .switch_set(switch_set[1])
);

stage_module stage2(
    .i_port(stage_2_input),
    .clk(clk),
    .o_port(stage_2_reg),
    .switch_set(switch_set[2])
);

stage_module stage3(
    .i_port(stage_3_input),
    .clk(clk),
    .o_port(stage_3_reg),
    .switch_set(switch_set[3])
);

stage_module stage4(
    .i_port(stage_4_input),
    .clk(clk),
    .o_port(o_port),
    .switch_set(switch_set[4])
);

endmodule