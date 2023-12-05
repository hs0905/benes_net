`timescale 1ps/1ps

module tb_codesign;

parameter clock_period = 10;

logic clk;
logic [3:0]i_port[0:15];
logic [3:0]o_port[0:15];
logic [3:0]switch_set[0:6];

task read_data();
    int file;
    string line;
    int skipped_line = 0;
    int i = 2;
    

    file = $fopen("/home/hs/Desktop/git/benes_network_algorithm/hw_sw_codesign/16X16_network/SW/output.txt","r");
    if(file)begin
        while(skipped_line <2) begin
            $fgets(line,file);
            skipped_line++;
        end

        while(!$feof(file) && i<10)//
        begin
            $fgets(line,file);//read a line and store it in 'line'
            switch_set[i-2] = 8'b00000000;
            for(int j=0;j<8;j++) //j<4 is for 4 bits
            begin
                switch_set[i-2][7-j] = (line[j]=="1") ? 1'b1 : 1'b0; //convert string to binary
            end
            i++;
        end
        $fclose(file);
    end
    else begin
        $display("Error in opening the file");
    end
endtask

network_module DUT(
    .clk(clk),
    .i_port(i_port),
    .o_port(o_port),
    .switch_set(switch_set)
);

always begin //clock generation

    #(clock_period/2) clk = ~clk;
end

initial begin

    clk = 1'b0;

    #clock_period;

    //reset
    foreach(i_port[j]) i_port[j] = 4'b0000;
    foreach(switch_set[j]) switch_set[j] = 8'b00000000;

    #clock_period;

    //read data from file
    read_data();

    #clock_period;

    foreach(i_port[i]) i_port[i] = i;

    #(clock_period*20);

end
endmodule