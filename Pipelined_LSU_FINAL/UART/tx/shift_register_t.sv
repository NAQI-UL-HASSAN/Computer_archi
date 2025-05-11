module shift_register_t(
    input  logic       clk,
    input  logic       reset,
    input  logic       load,
    input  logic [7:0] data_in,
    input  logic [15:0]brd,
    output logic       data_out,
    output logic       baud_clk_16,    // for simulation 
    output logic       done
);

baud_rate_transmitter baud_gen   (.clk          (clk),
                                  .reset        (reset),
                                  .baud_clk_16  (baud_clk_16),
                                  .brd          (brd)
                                  );

           logic a, b, c, d, e, f, g, h, i, j;
           logic       shift;
           logic [3:0] count;
    

    always_ff@(posedge baud_clk_16 or posedge reset)begin
        if (reset) begin
            j        <= 0;
            i        <= 0;
            h        <= 0;
            g        <= 0;
            f        <= 0;
            e        <= 0;
            d        <= 0;
            c        <= 0;
            b        <= 0;
            a        <= 0;
            data_out <= 1;
            shift    <= 0;
            done     <= 1;
            count    <= 0;
        end
        else if (load) begin
            j        <= 0;
            i        <= data_in[0];
            h        <= data_in[1];
            g        <= data_in[2];
            f        <= data_in[3];
            e        <= data_in[4];
            d        <= data_in[5];
            c        <= data_in[6];
            b        <= data_in[7];
            a        <= 1;
            done     <= 0;
            count    <= 0;
            shift    <= 1;
        end
        else if (shift) begin
            data_out <= j;
            j        <= i;
            i        <= h;
            h        <= g;
            g        <= f;
            f        <= e;
            e        <= d;
            d        <= c;
            c        <= b;
            b        <= a;
            count    <= count + 1;

            if (count == 10) begin
                done <= 1;
                shift <= 0;
                data_out <= 1;
            end
            else begin
                done <= 0;
            end
        end
        if (count != 10) begin
            done <= 0;
        end
    end

endmodule