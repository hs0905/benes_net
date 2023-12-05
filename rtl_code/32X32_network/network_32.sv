module	network_module#(
	parameter SIZE = 32,
	parameter LAYER_NUM = $clog2(SIZE), // layer_num : 5
	parameter STAGE_NUM = (LAYER_NUM*2)-1, // number of stages in the network 
	parameter DATA_WIDTH = 4, // data width of each port
	parameter SWITCH_NUM = SIZE/2,
	parameter MID_STAGE = STAGE_NUM/2,
	parameter BUFFER_NUM = STAGE_NUM - 1 // number of buffers in each stage : 
)(
	input logic clk, //clock
	input logic [DATA_WIDTH-1:0] i_port [0:SIZE-1], //input port
	output logic [DATA_WIDTH-1:0] o_port [0:SIZE-1], //output port
	input logic [SWITCH_NUM-1:0]switch_set[0:STAGE_NUM-1]//switch set for each stage
);

integer stage, layer, num_subnet, row_size, p_in, p_out, subnet,port_pos, subnet_pos;
logic [DATA_WIDTH-1:0] stage_in_reg[1:BUFFER_NUM][0:SIZE-1]; 
logic [DATA_WIDTH-1:0] stage_out_reg[0:BUFFER_NUM-1][0:SIZE-1];


always_ff@(posedge clk) begin
	for(stage = 0; stage<STAGE_NUM;stage++) begin
		layer = STAGE_NUM - $cabs(stage - MID_STAGE); // decide the layer number
		num_subnet = $cpow(2,layer); // decide the number of subnets in this stage
		row_size = SIZE / num_subnet; // decide the row size of each subnet
		subnet = p_out / row_size; // decide the subnet number
		for(integer p_out=0; p_out<SIZE ; p_out++)begin
			port_pos = p_out%2; // 0(upper_port), 1(lower_port)
			if(stage < MID_STAGE) begin
				if(!port_pos) begin // upper port
					p_in = (p_out % row_size)/2 + (row_size/2)*(2*subnet);
					stage_in_reg[stage+1][p_in] = stage_out_reg[stage][p_out];
				end else if(port_pos)begin // lower port
					p_in = (p_out % row_size)/2 + (row_size/2)*(2*subnet+1);
					stage_in_reg[stage+1][p_in] = stage_out_reg[stage][p_out];
				end
			end else if(stage >=MID_STAGE) begin
				subnet_pos = subnet %2; // 0(upper_subnet), 1(lower_subnet)
				if(!subnet_pos) begin // upper subnet
					p_in = (p_out % row_size)*2 + (subnet * row_size);
					stage_in_reg[stage+1][p_in] = stage_out_reg[stage][p_out];
				end else if(subnet_pos) begin // lower subnet
					p_in = (p_out % row_size)*2 + (subnet -1) * row_size +1 ;
					stage_in_reg[stage+1][p_in] = stage_out_reg[stage][p_out];
				end
			end
		end
	end
end

generate
	for(genvar stage_M = 1; stage_M<STAGE_NUM-1; stage_M++) begin // stage_M : stage_module 1 ~ 7
		stage_module #(.SIZE(SIZE), .WIDTH(DATA_WIDTH), .SWITCH_NUM(SWITCH_NUM)) 
		stage_inst(
			.clk(clk),
			.i_port(stage_in_reg[stage_M][0:SIZE-1]),
			.o_port(stage_out_reg[stage_M][0:SIZE-1]),
			.switch_set(switch_set[stage_M])
		);
	end
endgenerate

stage_module #(.SIZE(SIZE), .WIDTH(DATA_WIDTH), .SWITCH_NUM(SWITCH_NUM))
stage_0(
	.clk(clk),
	.i_port(i_port),
	.o_port(stage_out_reg[0][0:SIZE-1]),
	.switch_set(switch_set[0])
);

stage_module #(.SIZE(SIZE), .WIDTH(DATA_WIDTH), .SWITCH_NUM(SWITCH_NUM))
stage_last(
	.clk(clk),
	.i_port(stage_in_reg[STAGE_NUM-1][0:SIZE-1]),
	.o_port(o_port),
	.switch_set(switch_set[STAGE_NUM-1])
);

endmodule