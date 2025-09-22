module top_module (input x, input y, output z);
	wire w1, w2;
    A A_inst(.x(x), .y(y), .z(w1));
    B B_inst(.x(x), .y(y), .z(w2));
    
    assign z= w1 ^ w2;
    
    // could be reduced to z = x | ~y;
    
endmodule

module A(input x, input y, output z);
    assign z = x & ~y;
endmodule

module B(input x, input y, output z);
    assign z = ~(x ^ y);
endmodule