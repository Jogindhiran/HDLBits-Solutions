module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
	
    // State transition logic
    assign next_state[9:8] = state[6:5] & {2{~in}};
    assign next_state[7] = (state[6] | state[7]) & in;
    assign next_state[6:2] = state[5:1] & {5{in}}; 
    assign next_state[1] = (state[0] | state[8] | state[9]) & in;
    assign next_state[0] = (|state[4:0] | |state[9:7]) & ~in;
    
    // Output logic
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];
    
endmodule
