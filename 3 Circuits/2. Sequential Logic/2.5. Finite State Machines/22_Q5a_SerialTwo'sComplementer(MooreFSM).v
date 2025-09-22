module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter [1:0] A=0, B=1, C=2;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            A : next = x ? B : A;
            B : next = x ? C : B;
            C : next = x ? C : B;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= A;
        else
            state <= next;
    end
    
    assign z = (state == B);
endmodule
