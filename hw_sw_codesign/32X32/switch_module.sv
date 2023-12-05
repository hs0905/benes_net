module switch_module(
    input logic [3:0]i_port_0,
    input logic [3:0]i_port_1,
    input logic clk,
    input logic switch_set,
    output logic [3:0]o_port_0,
    output logic [3:0]o_port_1
);

always_comb begin
    if(!switch_set)//bar
    begin
        o_port_0 = i_port_0;
        o_port_1 = i_port_1;        
    end
    else begin
        o_port_0 = i_port_1;
        o_port_1 = i_port_0;
    end
end

endmodule