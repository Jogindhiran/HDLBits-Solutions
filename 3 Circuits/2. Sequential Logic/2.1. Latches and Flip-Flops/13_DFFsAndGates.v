module top_module (
    input clk,
    input x,
    output z
); 
    
    reg t1, t2, t3;

    always @(posedge clk) begin
        t1 <= t1 ^ x;
        t2 <= ~t2 & x;
        t3 <= ~t3 | x;
    end
    
    assign z = ~(t1 | t2 | t3);

endmodule