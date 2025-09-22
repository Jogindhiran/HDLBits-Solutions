module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter [1:0] A=0,B=1,C=2,D=3;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            A : begin
                if(r[1])
                    next = B;
                else if(~r[1] & r[2])
                    next = C;
                else if(~r[1] & ~r[2] & r[3])
                    next = D;
                else if(~r[1] & ~r[2] & ~r[3])
                    next = A;
            end
            
            B : next = r[1] ? B : A;
            C : next = r[2] ? C : A;
            D : next = r[3] ? D : A;
        endcase
    end
    
    always @(posedge clk) begin
        if(~resetn)
            state <= A;
        else
            state <= next;
    end
    
    assign g = {state == D,state == C,state == B};

endmodule
