module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    /*
    // Instantiating modules: 
    wire [2:0] cout;    
    full_adder FA1(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(cout[0]));
    full_adder FA2(.a(x[1]), .b(y[1]), .cin(cout[0]), .sum(sum[1]), .cout(cout[1]));
    full_adder FA3(.a(x[2]), .b(y[2]), .cin(cout[1]), .sum(sum[2]), .cout(cout[2]));
    full_adder FA4(.a(x[3]), .b(y[3]), .cin(cout[2]), .sum(sum[3]), .cout(sum[4]));
    */
    
    // Simplest method: 
    assign sum = x + y; // In verilog, addition automatically produces the carry-out bit which gets stored in sum[4]
    
    // assign sum = {x + y}; discards the carry out bit
endmodule

/*
module full_adder(input a, input b, input cin, output cout, output sum);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule
*/