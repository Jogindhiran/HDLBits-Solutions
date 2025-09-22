module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_d;

    always @(posedge clk) begin
        in_d <= in;
        if(reset)
            out <= '0;
        else
            out <= out | (in_d & ~in);
    end

endmodule
