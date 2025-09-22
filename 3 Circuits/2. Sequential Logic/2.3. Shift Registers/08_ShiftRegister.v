module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    
    MUXDFF inst( .clk(KEY[0]), .w(KEY[3]), .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[3]) );
    
    genvar i;
    generate 
        for(i=0;i<3;i++) begin: MUXDFF_Chain
            MUXDFF inst( .clk(KEY[0]), .w(LEDR[i+1]), .R(SW[i]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[i]) );
        end
    endgenerate
        
endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk) begin
        if(L)
            Q <= R;
        else begin
            if(E)
                Q <= w;
            else
                Q <= Q;
        end
    end
endmodule
