module controller_write_en(
    input  logic clk,
    input  logic reset,
    input  logic done,
    output logic enable
);

typedef enum logic [1:0] {S0 = 2'b00,
                          S1 = 2'b01,
                          S2 = 2'b10,
                          S3 = 2'b11
                         } do_it;

    do_it current_state;
    do_it next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state     <= S0;
        end
        else begin
            current_state     <= next_state;
        end
    end

    always_comb begin
        case(current_state)
            S0: if (!done) next_state = S0;
                else       next_state = S1;
                
            S1: if (!done) next_state = S2;
                else       next_state = S3;
                
            S2: if (!done) next_state = S0;
                else       next_state = S1;
                
            S3: if (!done) next_state = S2;
                else       next_state = S3;
        endcase
    end

    always_comb begin
        case (current_state)
            S0: if (!done) enable = 0;
                else       enable = 1;
          
            S1: enable = 0;
                
            S2: if (!done) enable = 0;
                else       enable = 1;
                
            S3: enable = 0;

        endcase
    end

endmodule