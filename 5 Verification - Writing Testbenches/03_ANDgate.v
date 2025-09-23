`timescale 1ps / 1ps
module top_module;
    reg [1:0] in;
    wire out;
    
    initial begin
        	in[1]=0; in[0]=0; // can be replaced with in = 2'b00
        #10 in[1]=0; in[0]=1;
        #10 in[1]=1; in[0]=0;
        #10 in[1]=1; in[0]=1;
    end
    
    andgate DUT(.in(in), .out(out));
    
endmodule
