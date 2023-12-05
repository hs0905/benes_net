module network_module(
    input logic clk,
    input logic [3:0]i_port[7:0],
    input logic [3:0]switch_set[4:0],//4bit 5stage switch_set
    output logic [3:0]o_port[7:0]
    );

    logic [3:0]stage0_result[7:0];
    logic [3:0]stage1_result[7:0];
    logic [3:0]stage2_result[7:0];
    logic [3:0]stage3_result[7:0];
    logic [3:0]stage4_result[7:0];

    logic [3:0]stage0_reg[7:0];
    logic [3:0]stage1_reg[7:0];
    logic [3:0]stage2_reg[7:0];
    logic [3:0]stage3_reg[7:0];

    always_ff@(posedge clk)begin //* 1 clock delay
        stage0_result <= stage0_reg;
        stage1_result <= stage1_reg;
        stage2_result <= stage2_reg;
        stage3_result <= stage3_reg;
        end

        stage_module stage0(
            .clk(clk),
            .i_port(i_port[7:0]),
            .switch_set(switch_set[0]),
            .o_port(stage0_reg[7:0])
        );

        stage_module stage1(
            .clk(clk),
            .i_port({stage0_result[0],stage0_result[2],stage0_result[4],stage0_result[6],
                    stage0_result[1],stage0_result[3],stage0_result[5],stage0_result[7]}),
            .switch_set(switch_set[1]),
            .o_port(stage1_reg[7:0])
        );

        stage_module stage2(
            .clk(clk),
            .i_port({stage1_result[0],stage1_result[2],stage1_result[1],stage1_result[3],
                    stage1_result[4],stage1_result[6],stage1_result[5],stage1_result[7]}),
            .switch_set(switch_set[2]),
            .o_port(stage2_reg[7:0])
        );

        stage_module stage3(
            .clk(clk),
            .i_port({stage2_result[0],stage2_result[2],stage2_result[1],stage2_result[3],
                    stage2_result[4],stage2_result[6],stage2_result[5],stage2_result[7]}),
            .switch_set(switch_set[3]),
            .o_port(stage3_reg[7:0])
        );

        stage_module stage4(
            .clk(clk),
            .i_port({stage3_result[0],stage3_result[4],stage3_result[1],stage3_result[5],
                    stage3_result[2],stage3_result[6],stage3_result[3],stage3_result[7]}),
            .switch_set(switch_set[4]),
            .o_port(o_port[7:0])
    );
endmodule