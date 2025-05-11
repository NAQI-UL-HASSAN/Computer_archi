module controller_fout(
    input  logic clk,
    input  logic reset,
    input  logic load,
    output logic f_out
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
            S0: if (!load) next_state = S0;
                else       next_state = S1;
                
            S1: if (!load) next_state = S2;
                else       next_state = S3;
                
            S2: if (!load) next_state = S0;
                else       next_state = S1;
                
            S3: if (!load) next_state = S2;
                else       next_state = S3;
        endcase
    end

    always_comb begin
        case (current_state)
            S0: if (!load) f_out = 0;
                else       f_out = 1;
          
            S1: if (!load) f_out = 0;
                else       f_out = 0;
                
            S2: if (!load) f_out = 0;
                else       f_out = 1;
                
            S3: if (!load) f_out = 0;
                else       f_out = 0;  
        endcase
    end

endmodule