module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
	
    reg w1;
    sub_module inst1(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[0]), .q_in(LEDR[2]), .Q(LEDR[0]));
    sub_module inst2(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[1]), .q_in(LEDR[0]), .Q(LEDR[1]));
    assign w1 = LEDR[2] ^ LEDR[1];
    sub_module inst3(.clk(KEY[0]), .L(KEY[1]), .r_in(SW[2]), .q_in(w1), .Q(LEDR[2]));

endmodule

module sub_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
	
    always @(posedge clk) begin
        Q <= (L)? r_in : q_in;
    end
    
endmodule
