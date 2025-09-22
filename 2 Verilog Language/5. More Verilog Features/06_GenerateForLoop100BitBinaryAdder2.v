module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    full_adder FA1(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .carry(cout[0]));
    
    genvar i;
    generate
        for(i=1; i<100; i++) begin: FA
            full_adder FA_instance(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .sum(sum[i]), .carry(cout[i]));
        end
    endgenerate
            
endmodule

module full_adder (input a, input b, input cin, output sum, output carry);
    assign sum = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (cin & a);
endmodule
