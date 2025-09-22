module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
	
    reg [2:0] ecounter;  
    initial pm = 0;
    
    assign ecounter[0] = ena;									// enable seconds counter
    assign ecounter[1] = ena && (ss == 8'h59);					// enable minutes counter
    assign ecounter[2] = ena && (ss == 8'h59) && (mm == 8'h59); // enable hours counter
    
    count60 ss_counter(
        .clk(clk),
        .reset(reset),
        .ena(ecounter[0]),
        .q(ss)
    );
    
    count60 mm_counter(
        .clk(clk),
        .reset(reset),
        .ena(ecounter[1]),
        .q(mm)
    );
    
    count12 hh_counter(
        .clk(clk),
        .reset(reset),
        .ena(ecounter[2]),
        .q(hh)
    );
    
    always @(posedge clk) begin
        if({hh,mm,ss} == {8'h11,8'h59,8'h59})
            pm <= ~pm;
    end  
endmodule

module count60(
    input clk,
    input reset,
    input ena,
    output [7:0] q);
    always @(posedge clk) begin
        if(reset)
            q <= 8'h0;
        else begin
            if(ena) begin
                if(q[3:0] < 4'h9)
                    q[3:0] <= q[3:0] + 4'h1;
                else begin
                    q[3:0] <= 4'h0;
                    if(q[7:4] < 4'h5)
                        q[7:4] <= q[7:4] + 4'h1;
                    else
                        q[7:4] <= 4'h0;
                end
            end
            else
                q <= q;
        end
    end
endmodule

module count12(
    input clk,
    input reset,
    input ena,
    output [7:0] q);
    
    always @(posedge clk) begin
        if(reset)
            q <= 8'h12;
        else begin
            if(ena) begin
                if(q[7:4] == 4'h0) begin
                    if(q[3:0] < 4'h9)
                        q[3:0] <= q[3:0] + 4'h1;
                    else begin
                        q[7:4] <= 4'h1;
                        q[3:0] <= 4'h0;
                    end
                end
                else begin
                    if(q[3:0] < 4'h2)
                        q[3:0] <= q[3:0] + 4'h1;
                    else begin
                        q[7:4] <= 4'h0;
                        q[3:0] <= 4'h1;
                    end
                end
            end
            else
                q <= q;
        end   
    end
endmodule
