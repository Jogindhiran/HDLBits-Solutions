module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);

    reg [7:0] d_in; // Previous state of in
    always @(posedge clk) begin
		d_in <= in;
        pedge <= in & ~d_in;
    end
    
endmodule
