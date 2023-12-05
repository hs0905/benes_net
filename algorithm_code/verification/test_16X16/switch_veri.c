#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#include<stdbool.h>

//===================================================================================================
// define the switch set
//===================================================================================================
#define BAR 0
#define CROSS 1
//===================================================================================================
// global variable
//===================================================================================================
int size;
int switch_size;
int tot_stage; 
int tot_layer;
int mid_stage;
int** switch_arr;
int* out_port;
int* table_out_port;
//===================================================================================================
// function prototype
//===================================================================================================
int Inner_sw(int sw_set, int port);
int Outer_sw(int stage,int p_out);
int path_finder(int port, int stage);
void dyna_alloc();
void initial_set(int current_size);
void read_input();
void test();

//===================================================================================================
// main function
//===================================================================================================
int main(){
    scanf("%d",&size); // read the size of the network
    dyna_alloc();// dynamic allocate the memory for the switch array
    initial_set(size);
    read_input();// read the input file
    

    for(int i=0; i<size;i++) // find the output port of each input port
        out_port[i] = path_finder(i,0); 
    
    test();
    return 0;
}

//===================================================================================================
// function definition
//===================================================================================================

void dyna_alloc(){ // dynamic allocate the memory for the switch array
    switch_size = size/2;
    switch_arr = (int **)malloc(switch_size * sizeof(int *));// the switch array
    for(int i = 0; i < switch_size; i++)// allocate the memory for each row
        switch_arr[i] = (int *)malloc(tot_stage * sizeof(int));   // allocate the memory for each column
    for(int i = 0; i < switch_size; i++)// initialize the switch array
        for(int j = 0; j < tot_stage; j++)
            switch_arr[i][j] = 0; 
    out_port = (int *)malloc(size * sizeof(int)); // the output port array
    for(int i = 0; i < size; i++)// initialize the output port array
        out_port[i] = 0;

    table_out_port = (int *)malloc(size * sizeof(int)); // the output port array
    for(int i = 0; i < size; i++)// initialize the output port array
        table_out_port[i] = 0;
}
void initial_set(int current_size){
    tot_stage = log2(current_size)*2 -1; // total number of stage
    tot_layer = log2(current_size); // total number of layer
    mid_stage = tot_stage / 2; //   the middle stage of the network
    

}
int Inner_sw(int sw_set, int port){
    
    bool port_pos = (port%2); // 0: upper , 1:lower

    switch (sw_set)
    {
    case BAR:
         port = port; break;
    
    case CROSS:
        if(port_pos)
        port = port - 1;
        else port = port + 1;
        break; 
    }

    return port; 
}

int Outer_sw(int stage,int p_out)
{  //P_out is the result of the inner switch, P_in is the input number of the next switch

    int p_in; 

    bool port_pos = (p_out%2); // 0: upper , 1:lower
    
    int layer = mid_stage - abs(stage - mid_stage);
    
    int num_subnet = pow(2,layer); // total number of subnetwork in each layer
 
    int row_size = size/num_subnet; // number of switch in each subnetwork

    int subnet = p_out / row_size ; // the subnet number of the switch 

    if(stage <mid_stage) // the first half of the stage
    {
        if(!port_pos)
            p_in = (p_out % row_size)/2 + (row_size/2) * (2 * subnet); // the upper port of the switch

        else if(port_pos)
            p_in = (p_out % row_size)/2 + (row_size/2) * (2 * subnet + 1);  // the lower port of the switch
    }else if(stage>=mid_stage) // the last half of the stage
    {
     bool subnet_pos = subnet % 2;

     if(!subnet_pos)
     p_in = (p_out % row_size)*2 + (subnet * row_size); // the upper port of the switch

     else if(subnet_pos)
     p_in = (p_out % row_size)*2 + (subnet -1) * row_size + 1; // the lower port of the switch

    }
    return p_in; 
}

int path_finder(int port, int stage){
    int final_port;
    int p_out;
    int next_p_in;
    int switch_set = switch_arr[port/2][stage]; // the switch set of the port
    if(stage != tot_stage -1){
    p_out = Inner_sw(switch_set, port); // the output port of the inner switch
    next_p_in = Outer_sw(stage, p_out); 
    return path_finder(next_p_in, stage+1);
    }
    else if(stage == tot_stage - 1)
    {
        final_port = Inner_sw(switch_set, port);
        return final_port;
    }
}

void read_input(){ // read the input file

    for(int i = 0; i<size; i++)
    scanf("%d",&table_out_port[i]);// read the output port of each input port

    for(int i = 0; i<switch_size; i++){// read the switch array
        for(int j = 0; j<tot_stage; j++)
        scanf("%d",&switch_arr[i][j]);
    }
}

void test(){ // test the output port of each input port
    int cnt = 0;
    for(int i = 0; i<size; i++){
        if(table_out_port[i] != out_port[i])
        cnt++;
    }

    if(cnt == 0)
    printf("good");
    else if(cnt != 0)
    printf("bad");
}