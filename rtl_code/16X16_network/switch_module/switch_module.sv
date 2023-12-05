module switch_module(
    input logic [3:0]i_port[1:0],
    input logic clk,
    input logic switch_set,
    output logic [3:0]o_port[1:0]
);

always_ff@(posedge clk)
begin
    if(!switch_set)//bar
    begin
        o_port[0] = i_port[0];
        o_port[1] = i_port[1];        
    end
    else begin
        o_port[0] = i_port[1];
        o_port[1] = i_port[0];
    end
end

endmodule