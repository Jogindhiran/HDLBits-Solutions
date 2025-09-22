module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
	
    assign out_sop = (c & d) | (~a & ~b & c);
    assign out_pos = (c) & (~a | b) & (~b | d); 
    // Group 0's and write in the same form as SOP. This will give ~F. Negate it again to get F in the form of POS
endmodule
