module top_module (
    input [7:0] in,
    output parity); 
    assign parity = (^in[7:0] == 0)? 1'b0 : 1'b1;
endmodule
