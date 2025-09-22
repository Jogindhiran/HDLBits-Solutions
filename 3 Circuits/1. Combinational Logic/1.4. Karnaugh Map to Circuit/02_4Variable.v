module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
	
    assign out = (~a & b & c) | (~b & ~c) | (a & c & d) | (~a & ~d);
endmodule
