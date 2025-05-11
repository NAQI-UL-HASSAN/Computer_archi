module sampler(
    input  logic       clk,
    input  logic       reset,
    input  logic       in_data,
    input  logic [15:0]brd,
    input  logic       out_mux,
    output logic       en,
    output logic       shift,
    output logic       baud_clk,
    output logic [3:0] counter      //# of repeated data bits
);

baud_clk_gen baud_clk_gen (.clk(clk),
                           .reset(reset),
                           .baud_clk(baud_clk),
                           .brd(brd)
                           );



    //COMPARATOR 
    always_comb begin
        if (in_data == out_mux) begin
            en = 1;
        end
        else begin
            en = 0;
        end
    end

    //counterER
    always_ff@(posedge baud_clk or posedge reset)begin
        if (reset) begin
            counter <= 4'b0;
            shift <= 0;
        end
        else if (en) begin
            counter <= counter + 1;
            if (counter == 4'd7) begin
                shift <= 1;
            end
            else begin
                shift <= 0;
            end
        end
        else if (counter == 4'd15) begin
            counter = 4'b0;
            shift <= 0;
        end
        else begin
            counter <= 0;
        end
    end

endmodule