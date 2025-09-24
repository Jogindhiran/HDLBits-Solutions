module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [1:0] PHT [0:127];  // Pattern History Table - 128 2-bit entries
    reg [6:0] GHR;			// Global History Register
    wire [6:0] train_index = train_pc ^ train_history;
    wire [6:0] predict_index = predict_pc ^ GHR;
    
    always @(*) begin
        if(predict_valid) begin
            predict_taken = (PHT[predict_index] > WNT);
            predict_history = GHR;
        end
        else begin
            predict_taken = 1'b0;
            predict_history = 7'd0;
        end
    end
    
    // 2-bit saturating counter (Training)
    parameter [1:0] SNT=0, WNT=1, WT=2, ST=3;
    integer i;
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            for(i = 0; i < 128; i++)
                PHT[i] <= WNT;
        else begin
            if(train_valid) begin
                case(PHT[train_index])
                    SNT: PHT[train_index] <= train_taken ? WNT : SNT;
                    WNT: PHT[train_index] <= train_taken ? WT : SNT;
                    WT:  PHT[train_index] <= train_taken ? ST : WNT;
                    ST:  PHT[train_index] <= train_taken ? ST : WT;
                endcase
            end
        end
    end
    
    // Branch history register (Prediction)
    always @(posedge clk, posedge areset) begin
        if(areset)
            GHR <= 0;
        else begin
            if(train_valid && train_mispredicted)
                GHR <= {train_history[5:0],train_taken};
            else if(predict_valid)
                GHR <= {GHR[5:0],predict_taken};
        end
    end
    
endmodule
