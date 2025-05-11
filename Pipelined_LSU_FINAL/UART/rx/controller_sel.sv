module controller_sel(
    input  logic       clk,
    input  logic       reset,
    input  logic [3:0] Count,   //# of bits in shift reg
    output logic       sel 
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
                sel = 0;
            end
            X     : begin
                sel = 1;
            end
        endcase
    end

    always_comb begin
        case(state)
            RESET : begin
                if ((Count == 0)) begin
                    nextstate = RESET;
                end
                else if ((Count > 0) & (Count < 11)) begin
                    nextstate = X;
                end
                else begin
                    nextstate = RESET;
                end
            end
            X     : begin
                if ((Count > 0) & (Count < 11)) begin
                    nextstate = X;
                end
                else if ((Count == 0)) begin
                    nextstate = RESET;
                end
                else begin
                    nextstate = RESET;
                end
            end
        endcase
    end
endmodule