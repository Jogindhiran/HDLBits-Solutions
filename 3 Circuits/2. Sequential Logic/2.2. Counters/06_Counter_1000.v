module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);

    wire [3:0] w1, w2, w3;

    bcdcount counter0 (clk, reset, c_enable[0], w1);
    bcdcount counter1 (clk, reset, c_enable[1], w2);
    bcdcount counter2 (clk, reset, c_enable[2], w3);
    
    always @(*) begin
        c_enable[0] = 1'b1;
        c_enable[1] = (w1 == 4'd9);
        c_enable[2] = (w1 == 4'd9 && w2 == 4'd9);
    end
    
    assign OneHertz = ((w1 == 4'd9) && (w2 == 4'd9) & (w3 == 4'd9));

endmodule
