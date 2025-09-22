module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
	
    reg [2:0] w;
    
    always @(posedge clk) begin
        if(!resetn) begin
            out <= 1'b0;
            w <= 3'h0;
        end
        else begin
            w[2] <= in;
            w[1] <= w[2];
            w[0] <= w[1];
            out <= w[0];
        end
    end
endmodule
