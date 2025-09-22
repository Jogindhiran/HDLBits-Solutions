module top_module (
    input clk,
    input d,
    output q
);

    reg n, p;

    always @(posedge clk)
        p <= n ^ d;
    always @(negedge clk)
        n <= p ^ d;
    assign q = p ^ n;

endmodule
