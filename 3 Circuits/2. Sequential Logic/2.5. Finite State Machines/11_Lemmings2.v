module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter [2:0] LEFT = 2'h0, RIGHT = 2'h1, LEFT_FALL = 2'h2, RIGHT_FALL = 2'h3;
    reg [2:0] state, next_state;
    
    always @(*) begin
        case(state)
            LEFT : next_state = (!ground)? LEFT_FALL : ((bump_left) ? RIGHT : LEFT);
            RIGHT : next_state = (!ground)? RIGHT_FALL : ((bump_right) ? LEFT : RIGHT);
            LEFT_FALL : next_state = (ground) ? LEFT : LEFT_FALL;
            RIGHT_FALL : next_state = (ground) ? RIGHT : RIGHT_FALL;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            LEFT  : {walk_left, walk_right, aaah} = 3'b100;
            RIGHT : {walk_left, walk_right, aaah} = 3'b010;
            LEFT_FALL : {walk_left, walk_right, aaah} = 3'b001;
            RIGHT_FALL : {walk_left, walk_right, aaah} = 3'b001;
        endcase
    end
    

endmodule
