module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter [1:0] SNT=0, WNT=1, WT=2, ST=3;
    reg [1:0] st, next;
    
    always @(*) begin
        case(state)
            SNT : next = train_taken? WNT : SNT;
            WNT : next = train_taken? WT : SNT;
            WT  : next = train_taken? ST : WNT;
            ST  : next = train_taken? ST : WT;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            st <= WNT;
        else begin
            if(train_valid)
                st <= next;
            else
                st <= st;
        end
    end
    
    assign state = st;
    
endmodule
