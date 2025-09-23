module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    always @(*) begin
        case(state)
            1'b0 : q = a ^ b;
            1'b1 : q = ~(a ^ b);
        endcase
    end
    
    always @(posedge clk) begin
        if(a==b)
            state <= a;
        else
            state <= state;
    end
  
endmodule
