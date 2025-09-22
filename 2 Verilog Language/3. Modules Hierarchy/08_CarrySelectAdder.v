module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
	
    wire [15:0] sum1, sum2, res1, res2;
    wire cmux, c1, c2;
    
    add16 inst1(.a(a[15:0]), .b(b[15:0]), .cin(0), .sum(res1), .cout(cmux));
    add16 inst2(.a(a[31:16]), .b(b[31:16]), .cin(0), .sum(sum1), .cout(c1));
    add16 inst3(.a(a[31:16]), .b(b[31:16]), .cin(1), .sum(sum2), .cout(c2));
    
    always@(*) begin
        case(cmux)
            1'b0 : res2 = sum1;
            1'b1 : res2 = sum2;
        endcase
    end
    
    assign sum = {res2,res1};
    
endmodule
