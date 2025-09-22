module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] d_in;
    always @(posedge clk) begin
    	for(int i=0; i<$bits(in); i++) begin
            d_in <= in;
            anyedge <= d_in ^ in; // xor = (~d_in & in) | (d_in & ~in);
        end
    end

endmodule
