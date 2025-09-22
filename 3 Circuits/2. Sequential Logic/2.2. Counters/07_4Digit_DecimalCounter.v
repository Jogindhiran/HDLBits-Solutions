module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    always @(posedge clk) begin
        if(reset || q == 16'h9999) begin
            q <= 0;
            ena <= 0;
        end
        else begin
            ena <= {(q[11:8]==9 && q[7:4]==9 && q[3:0]==8),(q[7:4]==9 && q[3:0]==8),(q[3:0]==8)};
            q[3:0] <= (q[3:0] == 9)? 0 : q[3:0] + 1;
            if(ena[1] == 1)
                q[7:4] <= (q[7:4] == 9)? 0 : q[7:4] + 1;
            if(ena[2] == 1)
                q[11:8] <= (q[11:8] == 9)? 0 : q[11:8] + 1;
            if(ena[3] == 1)
                q[15:12] <= (q[15:12] == 9)? 0 : q[15:12] + 1;
        end
    end
    
endmodule
