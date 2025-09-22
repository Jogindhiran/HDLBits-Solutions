module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
	
    reg [7:0] Q;
    
    always @(posedge clk) begin
        if(enable)
            Q <= {Q[6:0], S};
    end
    
// Simple version: Use an assign statement
    assign Z = Q[ {A,B,C} ];
        
/*  Creating a MUX using combinational always and case statement  
    always @(*) begin
        case({A,B,C})
            3'h0 : Z = Q[0];
            3'h1 : Z = Q[1];
            3'h2 : Z = Q[2];
            3'h3 : Z = Q[3];
            3'h4 : Z = Q[4];
            3'h5 : Z = Q[5];
            3'h6 : Z = Q[6];
            3'h7 : Z = Q[7];
        endcase
    end
*/
endmodule

    
