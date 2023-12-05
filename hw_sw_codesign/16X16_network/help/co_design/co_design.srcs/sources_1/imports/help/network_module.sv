module network_module(
    input logic clk,
    input logic [3:0]i_port[0:15],
    input logic [7:0]switch_set[0:6], // 8 switch in a row, 7 stage
    output logic [3:0]o_port[0:15]
    );
 
    logic [3:0]stage_in_reg_1[0:15];
    logic [3:0]stage_in_reg_2[0:15];
    logic [3:0]stage_in_reg_3[0:15];
    logic [3:0]stage_in_reg_4[0:15];
    logic [3:0]stage_in_reg_5[0:15];
    logic [3:0]stage_in_reg_6[0:15];

    logic [3:0]stage_out_reg_0[0:15];
    logic [3:0]stage_out_reg_1[0:15];
    logic [3:0]stage_out_reg_2[0:15];
    logic [3:0]stage_out_reg_3[0:15];
    logic [3:0]stage_out_reg_4[0:15];
    logic [3:0]stage_out_reg_5[0:15];
   

    always_ff@(posedge clk) begin : stage_path
        stage_in_reg_1 <= { // stage 0 -> stage 1
            stage_out_reg_0[0],
            stage_out_reg_0[2],
            stage_out_reg_0[4],
            stage_out_reg_0[6],
            stage_out_reg_0[8],
            stage_out_reg_0[10],
            stage_out_reg_0[12],
            stage_out_reg_0[14],
            stage_out_reg_0[1],
            stage_out_reg_0[3],
            stage_out_reg_0[5],
            stage_out_reg_0[7],
            stage_out_reg_0[9],
            stage_out_reg_0[11],
            stage_out_reg_0[13],
            stage_out_reg_0[15]
        };

        stage_in_reg_2 <= { // stage 1 -> stage 2
            stage_out_reg_1[0],
            stage_out_reg_1[2],
            stage_out_reg_1[4],
            stage_out_reg_1[6],
            stage_out_reg_1[1],
            stage_out_reg_1[3],
            stage_out_reg_1[5],
            stage_out_reg_1[7],
            stage_out_reg_1[8],
            stage_out_reg_1[10],
            stage_out_reg_1[12],
            stage_out_reg_1[14],
            stage_out_reg_1[9],
            stage_out_reg_1[11],
            stage_out_reg_1[13],
            stage_out_reg_1[15]
        };

        stage_in_reg_3 <= { // stage 2 -> stage 3
            stage_out_reg_2[0],
            stage_out_reg_2[2],
            stage_out_reg_2[1],
            stage_out_reg_2[3],
            stage_out_reg_2[4],
            stage_out_reg_2[6],
            stage_out_reg_2[5],
            stage_out_reg_2[7],
            stage_out_reg_2[8],
            stage_out_reg_2[10],
            stage_out_reg_2[9],
            stage_out_reg_2[11],
            stage_out_reg_2[12],
            stage_out_reg_2[14],
            stage_out_reg_2[13],
            stage_out_reg_2[15]
        };

        stage_in_reg_4 <= { // stage 3 -> stage 4
            stage_out_reg_3[0],
            stage_out_reg_3[2],
            stage_out_reg_3[1],
            stage_out_reg_3[3],
            stage_out_reg_3[4],
            stage_out_reg_3[6],
            stage_out_reg_3[5],
            stage_out_reg_3[7],
            stage_out_reg_3[8],
            stage_out_reg_3[10],
            stage_out_reg_3[9],
            stage_out_reg_3[11],
            stage_out_reg_3[12],
            stage_out_reg_3[14],
            stage_out_reg_3[13],
            stage_out_reg_3[15]
        };

        stage_in_reg_5 <= { // stage 4 -> stage 5
            stage_out_reg_4[0],
            stage_out_reg_4[4],
            stage_out_reg_4[1],
            stage_out_reg_4[5],
            stage_out_reg_4[2],
            stage_out_reg_4[6],
            stage_out_reg_4[3],
            stage_out_reg_4[7],
            stage_out_reg_4[8],
            stage_out_reg_4[12],
            stage_out_reg_4[9],
            stage_out_reg_4[13],
            stage_out_reg_4[10],
            stage_out_reg_4[14],
            stage_out_reg_4[11],
            stage_out_reg_4[15]
        };

        stage_in_reg_6 <= { // stage 5 -> stage 6
            stage_out_reg_5[0],
            stage_out_reg_5[8],
            stage_out_reg_5[1],
            stage_out_reg_5[9],
            stage_out_reg_5[2],
            stage_out_reg_5[10],
            stage_out_reg_5[3],
            stage_out_reg_5[11],
            stage_out_reg_5[4],
            stage_out_reg_5[12],
            stage_out_reg_5[5],
            stage_out_reg_5[13],
            stage_out_reg_5[6],
            stage_out_reg_5[14],
            stage_out_reg_5[7],
            stage_out_reg_5[15]
        };
    end
    
    stage_module stage0(
        .clk(clk),
        .switch_set(switch_set[0]),
        .i_port(i_port), // input port
        .o_port(stage_out_reg_0) // stage 0 -> stage 1
    );

    stage_module stage1(
        .clk(clk),
        .switch_set(switch_set[1]),
        .i_port(stage_in_reg_1), // stage 0 -> stage 1
        .o_port(stage_out_reg_1) // stage 1 -> stage 2
    );

    stage_module stage2(
        .clk(clk),
        .switch_set(switch_set[2]),
        .i_port(stage_in_reg_2), // stage 1 -> stage 2
        .o_port(stage_out_reg_2) // stage 2 -> stage 3
    );

    stage_module stage3(
        .clk(clk),
        .switch_set(switch_set[3]),
        .i_port(stage_in_reg_3), // stage 2 -> stage 3
        .o_port(stage_out_reg_3) // stage 3 -> stage 4
    );
    
    stage_module stage4(
        .clk(clk),
        .switch_set(switch_set[4]),
        .i_port(stage_in_reg_4), // stage 3 -> stage 4
        .o_port(stage_out_reg_4) // stage 4 -> stage 5
    );            

    stage_module stage5(
        .clk(clk),
        .switch_set(switch_set[5]),
        .i_port(stage_in_reg_5), // stage 4 -> stage 5
        .o_port(stage_out_reg_5) // stage 5 -> stage 6
    );    

    stage_module stage6(
        .clk(clk),
        .switch_set(switch_set[6]),
        .i_port(stage_in_reg_6), // stage 5 -> stage 6
        .o_port(o_port) // output port
    );
endmodule