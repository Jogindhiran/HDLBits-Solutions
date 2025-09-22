module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=0,B=1;
    reg state, next;
    reg [1:0] count, one;
    always @(*) begin
        case(state)
            A : next = s ? B : A;
            B : next = B;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next;
    end
    
    always @(posedge clk) begin
        if(reset) begin
            count = 0;
            one = 0;
        end
        else if(state == B) begin   
            if(count == 3) begin
                count = 0;
                one = 0;
            end
            if(w==1)
                one = one + 1;
            
            count = count + 1;
        end
    end
    
    assign z = (count==3 & one==2);
endmodule
