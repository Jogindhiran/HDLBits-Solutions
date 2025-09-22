module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
	
    wire [15:0][15:0] qm, qm_next; // Realising 256 bit 1D vector as a 16 x 16 bit 2D vector
    assign qm = q;
    
    // Calculating bit_sum for each cell and updating qm_next
    genvar x,y;
    generate
        for(x=0;x<16;x++) begin: row
            for(y=0;y<16;y++) begin: column
                wire[3:0] result;
                bit_sum inst(
                    {
                        // Populating the 8 bit input according to 16 x 16 toroidal grid conditions
                        qm[x==0 ? 15 : x-1][y],					// Upper cell
                        qm[x==0 ? 15 : x-1][y==0 ? 15 : y-1], 	// Upper left cell
                        qm[x==0 ? 15 : x-1][y==15 ? 0 : y+1],	// Upper right cell
                        qm[x==15 ? 0 : x+1][y],					// Lower cell
                        qm[x==15? 0 : x+1][y==0 ? 15 : y-1],	// Lower left cell
                        qm[x==15? 0 : x+1][y==15 ? 0 : y+1],	// Lower right cell
                        qm[x][y==0? 15 : y-1],					// Cell on left
                        qm[x][y==15? 0 : y+1]					// Cell on right
                    }, result
                );
                
                // Assigning qm_next based on the rules
                always @(*) begin
                    case(result)
                        //4'h0 : qm_next[x][y] = 1'b0;
                        //4'h1 : qm_next[x][y] = 1'b0;
                        4'h2 : qm_next[x][y] = qm[x][y];
                        4'h3 : qm_next[x][y] = 1'b1;
                        default: qm_next[x][y] = 1'b0;
                    endcase
                end
                
            end
        end
    endgenerate
    
    always @(posedge clk) begin
        if(load)
            q <= data;
        else
            q <= qm_next;
    end
    
endmodule

// To calculate the number of 1s in 8 neighbouring cells
module bit_sum(
    input [7:0] in,
    output [3:0] result
);
    assign result = in[0] + in[1] + in[2] + in[3] + in[4] + in[5] + in[6] + in[7];
endmodule