module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    always @(posedge clk) begin
        case(byteena)
            2'b00 : q <= q;
            2'b01 : q[7:0] <= (resetn)? d[7:0] : 8'd0;
            2'b10 : q[15:8] <= (resetn)? d[15:8] : 8'd0;
            2'b11 : q <= (resetn)? d : 8'd0;
        endcase
    end
            
        
endmodule
