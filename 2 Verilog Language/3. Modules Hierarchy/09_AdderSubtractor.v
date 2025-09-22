module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire [31:0] xorb;
    wire [15:0] sum1, sum2;
    wire c1, c2;
    
    assign xorb = {32{sub}} ^ b;
    add16 inst1(.a(a[15:0]), .b(xorb[15:0]), .cin(sub), .sum(sum1), .cout(c1));
    add16 inst2(.a(a[31:16]), .b(xorb[31:16]), .cin(c1), .sum(sum2), .cout(c2));
    
    assign sum = {sum2,sum1};
    
endmodule
