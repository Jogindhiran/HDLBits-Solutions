module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter [2:0] IDLE=0, START=1, DATA=2, STOP=3, WAIT=4;
    reg [2:0] state, next_state;
    reg [3:0] count;
    reg [7:0] out;
    
    always @(*) begin
        case(state)
            IDLE :  next_state = (in)? IDLE : START;
            START:  next_state = DATA;
            DATA :  next_state = (count < 4'h8)? DATA : ( (in)? STOP : WAIT );
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
            done <= 0;
        end
        else begin
            case(next_state)
                DATA : begin
                    count <= count + 1;
                    done <= 0;
                end
                STOP : begin
                    count <= 0;
                    done <= 1;
                end
                default : begin
                    count <= 0;
                    done <= 0;
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
    
    assign out_byte = (done)? out : 1'b0;
endmodule
