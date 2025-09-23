`timescale 1ps / 1ps
module top_module;
    reg clk, reset, t;
    wire q;
    
    tff DUT(.clk(clk), .reset(reset), .t(t), .q(q));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset=1; t=0;
        #10 reset=0; t=1;
    end

endmodule
