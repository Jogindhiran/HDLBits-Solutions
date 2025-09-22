module top_module( 
    input [254:0] in,
    output [7:0] out );
	
    always @(*) begin
        out = 0;
        for(int i=0; i<$bits(in); i++)
            out = out + in[i]; // if in[i] = 1, it is added, if in[i] = 0, then adding doesn't make sense 
    end
    
endmodule
