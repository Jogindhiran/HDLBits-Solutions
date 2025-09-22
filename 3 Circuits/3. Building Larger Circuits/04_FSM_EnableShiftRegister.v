module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
	
    parameter [2:0] A=0,B=1,C=2,D=3,E=4;
    reg [2:0] state, next;
    integer count;
    
    always @(*) begin
        case(state)
            A : next = B;
            B : next = C;
            C : next = D;
            D : next = E;
            E : next = E;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next;
    end
    
    assign shift_ena = (state == A || state == B || state == C || state == D);
endmodule
