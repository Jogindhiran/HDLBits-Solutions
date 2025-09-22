module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
	
    wire [99:0] c_inter;
    bcd_fadd BCD_FA1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(c_inter[0]), .sum(sum[3:0]));
    
    genvar i;
 
    generate
        for(i=1; i<100; i = i + 1) begin: BCD_FA
            bcd_fadd BCD_FA_inst(.a(a[i*4+3:i*4]), .b(b[i*4+3:i*4]), .cin(c_inter[i-1]), .cout(c_inter[i]), .sum(sum[i*4+3:i*4]));
        end
    endgenerate
    
    assign cout = c_inter[99];
   
endmodule
