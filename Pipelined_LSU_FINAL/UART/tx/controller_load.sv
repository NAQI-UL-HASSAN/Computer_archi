module controller_load(
    input  logic reset,
    input  logic clk,
    input  logic fe,
    input  logic done,
    input  logic [15:0]brd,
    output logic baud_clk_16,
    output logic load
);

baud_rate_transmitter baud_gen   (.clk          (clk),
                                  .reset        (reset),
                                  .baud_clk_16  (baud_clk_16),
                                  .brd          (brd) 
                                  );


    typedef enum logic {RESET = 0,
                        X     = 1
                       } do_it;

    do_it state;
    do_it nextstate;

    always_ff @(posedge baud_clk_16 or posedge reset) begin
        if (reset) begin
            state     <= RESET;
        end
        else begin
            state     <= nextstate;
        end
    end

    always_comb begin
        case(state)
            RESET : begin 
                load = 0;
            end
            X     : begin
                load = 1;
            end
        endcase
    end

    always_comb begin
        case(state)
            RESET : begin
                if ((!fe) & (!done)) begin
                    nextstate = RESET;
                end
                else if (fe) begin
                    nextstate = RESET;
                end
                else if ((!fe) & (done)) begin
                    nextstate = X;
                end
                else begin            //???????????/
                    nextstate = RESET;
                end
            end
            X     : begin
                nextstate = RESET;
            end
        endcase
    end
endmodule