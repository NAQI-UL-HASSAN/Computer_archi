module controller_wr_en(
    input  logic reset,
    input  logic clk,
    input  logic busy,
    input  logic ff,
    output logic write_en
);

    typedef enum logic {RESET = 0,
                        X     = 1
                       } do_it;

    do_it state;
    do_it nextstate;

    always_ff @(posedge clk or posedge reset) begin
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
                write_en = 0;
            end
            X     : begin
                write_en = 1;
            end
        endcase
    end

    always_comb begin
        case(state)
            RESET : begin
                if ((busy) & (ff)) begin
                    nextstate = RESET;
                end
                else if (!busy) begin
                    nextstate = RESET;
                end
                else if ((busy) & (!ff)) begin
                    nextstate = X;
                end
                else begin            //???????????/
                    nextstate = RESET;
                end
            end
            X     : begin
                if ((busy) & (!ff)) begin
                    nextstate = X;
                end
                else if (!busy) begin
                    nextstate = RESET;
                end
                else if ((busy) & (ff)) begin
                    nextstate = RESET;
                end
                else begin   //???????????
                    nextstate = X;
                end
            end
        endcase
    end
endmodule