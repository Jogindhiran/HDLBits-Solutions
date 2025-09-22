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

    parameter [2:0] WLEFT = 3'h0, WRIGHT = 3'h1, LFALL = 3'h2, RFALL = 3'h3, LDIG = 3'h4, RDIG = 3'h5, SPLAT = 3'h6;
    reg [2:0] state, next_state;

    // Note: Count can be extended according to the gaming requirements. In this version, an 8 bit count is chosen
    // which means SPLAT works fine if Lemming falls for atmost 255 clock cycles.
    // At 256th clock cycle, count becomes 0 because of memory constraint. 
    // If ground == 1 at 256th clock cycle, then it won't splatter as count == 0.
    reg [7:0] count;
    initial count = 0;
    
    always @(*) begin
        case(state)
            WLEFT  : next_state = (!ground)? LFALL : ( (dig)? LDIG : ((bump_left)? WRIGHT : WLEFT) );
            WRIGHT : next_state = (!ground)? RFALL : ( (dig)? RDIG : ((bump_right)? WLEFT : WRIGHT) );
            LFALL  : next_state = (!ground)? LFALL : ( (count > 8'd20)? SPLAT : WLEFT );
            RFALL  : next_state = (!ground)? RFALL : ( (count > 8'd20)? SPLAT : WRIGHT );
            LDIG   : next_state = (!ground)? LFALL : LDIG;
            RDIG   : next_state = (!ground)? RFALL : RDIG;
            SPLAT  : next_state = SPLAT;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= WLEFT;
        else
            state <= next_state;
    end
    
    // Counter to track fall of Lemming
    always @(posedge clk, posedge areset) begin
        if(areset)
            count <= 0;
        else if(!ground)
            count <= count + 1'b1;
        else
            count <= 0;
    end
    
    assign walk_left = (state == WLEFT);
    assign walk_right = (state == WRIGHT);
    assign aaah = ((state == LFALL) || (state == RFALL));
    assign digging = ((state == LDIG) || (state == RDIG));
    
endmodule
