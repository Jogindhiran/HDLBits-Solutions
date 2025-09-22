module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);  
    always @(*) begin
        case(x)
            1'b0 : Y0 = (y == 3'b001 || y == 3'b011 || y == 3'b100);
            1'b1 : Y0 = (y == 3'b000 || y == 3'b010);
            default : Y0 = 1'b0;
        endcase
    end
    
    assign z = (y == 3'b011 || y == 3'b100);
        
endmodule
