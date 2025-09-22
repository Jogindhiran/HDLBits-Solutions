module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
	
    parameter [2:0] A=0, B=1, C=2, D=3, E=4;
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            A : next = x ? B : A;
            B : next = x ? E : B;
            C : next = x ? B : C;
            D : next = x ? C : B;
            E : next = x ? E : D;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next;
    end
    
    assign z = (state == D | state == E);
endmodule
