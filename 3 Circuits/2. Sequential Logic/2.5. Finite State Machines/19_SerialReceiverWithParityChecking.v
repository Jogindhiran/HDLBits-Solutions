module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter [2:0] IDLE=0, START=1, DATA=2, STOP=3, WAIT=4, CHECK=5;
    reg [2:0] state, next_state;
    reg [3:0] count;
    reg [7:0] out;
    reg odd_reg;
    reg odd_reset;
    wire odd;
    
    always @(*) begin
        case(state)
            IDLE :  next_state = (in)? IDLE : START;
            START:  next_state = DATA;
            DATA :  next_state = (count == 4'h8)? CHECK : DATA;
            CHECK:  next_state = (in)? STOP : WAIT;
            STOP :  next_state = (in)? IDLE : START;
            WAIT :  next_state = (in)? IDLE : WAIT;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    always @(posedge clk) begin
        if(reset) begin
            count <= 0;
        end
        else begin
            case(next_state)
                DATA : begin
                    count <= count + 1;
                end
                STOP : begin
                    count <= 0;
                end
                default : begin
                    count <= 0;
                end
            endcase
        end 
    end
    
    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if(reset)
            out <= 0;
        else if(next_state == DATA)
            out[count] <= in;
    end

    // New: Add parity checking.
    parity inst1(
        .clk(clk),
        .reset(reset | odd_reset),
        .in(in),
        .odd(odd)
    );
    
    always @(posedge clk) begin
        if(reset)
            odd_reg <= 0;
        else
            odd_reg <= odd;
    end
    
    always @(posedge clk) begin
        case(next_state)
            IDLE: odd_reset = 1;
            STOP: odd_reset = 1;
            default odd_reset = 0;
        endcase
    end
    
    assign done = (state==STOP && odd_reg);
    assign out_byte = (done)? out : 8'b0;
endmodule
