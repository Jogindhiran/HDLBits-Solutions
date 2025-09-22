module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 
    
    reg [511:0] L;	// Left neighbour
    reg [511:0] R;	// Right neighbour
    assign L = {1'b0,q[511:1]};
    assign R = {q[510:0],1'b0};
    
    always @(posedge clk) begin
        if(load)
            q <= data;
        else begin
            q <= (~L & R) | (q ^ R);
        end
    end
endmodule
