module top_module (
    input [3:1] y,
    input w,
    output Y2);
	
    always @(*) begin
        case(w)
            1'b0 : Y2 = (y == 3'b001 || y == 3'b101);
            1'b1 : Y2 = (y == 3'b001 || y == 3'b010 || y == 3'b100 || y == 3'b101);
        endcase
    end
    
endmodule
