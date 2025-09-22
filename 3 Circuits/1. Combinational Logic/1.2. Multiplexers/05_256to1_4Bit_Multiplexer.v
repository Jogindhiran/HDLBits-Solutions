module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
	
    // This won't work
    // assign out = in[sel*4 + 3 : sel*4];
    
    // Indexed vector part select
    assign out = in[(sel*4 + 3) -: 4]; //selects sel*4 + 3, then -: 4 indicates it extends downwards till 4th bit. 
    
endmodule
