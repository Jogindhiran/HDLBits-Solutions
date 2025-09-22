module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire cout_inter[3:0];
    
    bcd_fadd bcdFA_inst1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout_inter[0]), .sum(sum[3:0]));
    
    genvar i;
    generate
        for(i=1;i<$size(cout_inter);i++) begin: bcd_FA
            bcd_fadd bcdFA_inst(
                .a(a[4*i + 3:4*i]), .b(b[4*i + 3:4*i]), .cin(cout_inter[i-1]), 
                .cout(cout_inter[i]), .sum(sum[4*i + 3:4*i])
            );
        end
    endgenerate
    
    assign cout = cout_inter[3];
    
endmodule
