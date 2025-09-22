module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    parameter [3:0] A=0, B=1, P1=2, P2=3, P3=4, G1=5, G1P=6,TMP1=7, G0P=8;
    reg [3:0] state, next;
    
    always @(*) begin
        case(state)
            A : next = (~resetn) ? A : B;
            B : next = P1;
            
            P1 : next = x ? P2 : P1;
            P2 : next = x ? P2 : P3;
            P3 : next = x ? G1 : P1;
            
            G1 : next = y ? G1P : TMP1;		  // clk cycle 1
            TMP1 : next = y ? G1P : G0P; 	  // clk cycle 2
            G1P : next = (~resetn)? A : G1P;
            G0P : next = (~resetn)? A : G0P;
        endcase
    end
    
    always @(posedge clk) begin
        if(~resetn)
            state <= A;
        else
            state <= next;
    end
    
    always @(posedge clk) begin
        case(next)
            B : f <= 1'b1;
            G1 : g <= 1'b1;
            TMP1 : g <= 1'b1;
            G1P : g <= 1'b1;
            G0P : g <= 1'b0;
            default: begin
                f <= 1'b0;
                g <= 1'b0;
            end
        endcase
    end
            
endmodule
