module top_module (
    input d, 
    input ena,
    output q);

    always @(*)
        q <= (ena)? d : q;
        
endmodule
