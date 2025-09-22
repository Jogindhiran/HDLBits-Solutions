module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
	
    parameter [2:0] WLEFT = 3'h0, WRIGHT = 3'h1, LFALL = 3'h2, RFALL = 3'h3, LDIG = 3'h4, RDIG = 3'h5;
    reg [2:0] state, next_state;
    
    always @(*) begin
        case(state)
            WLEFT  : next_state = (!ground)? LFALL : ( (dig)? LDIG : ((bump_left)? WRIGHT : WLEFT) );
            WRIGHT : next_state = (!ground)? RFALL : ( (dig)? RDIG : ((bump_right)? WLEFT : WRIGHT) );
            LFALL  : next_state = (!ground)? LFALL : WLEFT;
            RFALL  : next_state = (!ground)? RFALL : WRIGHT;
            LDIG   : next_state = (!ground)? LFALL : LDIG;
            RDIG   : next_state = (!ground)? RFALL : RDIG;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= WLEFT;
        else
            state <= next_state;
    end
    
    assign walk_left = (state == WLEFT);
    assign walk_right = (state == WRIGHT);
    assign aaah = ((state == LFALL) || (state == RFALL));
    assign digging = ((state == LDIG) || (state == RDIG));
    
endmodule
