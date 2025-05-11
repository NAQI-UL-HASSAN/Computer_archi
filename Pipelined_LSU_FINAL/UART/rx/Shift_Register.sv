module Shift_Register(
    input  logic       reset,
    input  logic       clk,
    input  logic       data_in,
    input  logic       shift_in,
    input  logic [15:0]brd,
    output logic       done,
    output logic [7:0] data_out,
    output logic [3:0] count
);
logic       baud_clk;                 
baud_clk_gen baud_clk_gen (.clk(clk),
                           .reset(reset),
                           .baud_clk(baud_clk),
                           .brd(brd)
                           );

           logic a, b, c, d, e, f, g, h, i, j;

    always_ff @(posedge baud_clk or posedge reset)begin
        if (reset) begin
            j        <= 1;
            i        <= 1;
            h        <= 1;
            g        <= 1;
            f        <= 1;
            e        <= 1;
            d        <= 1;
            c        <= 1;
            b        <= 1;
            a        <= 1;
            done     <= 0;
            count    <= 0;
            data_out <= {b,c,d,e,f,g,h,i};
        end
        else if (shift_in) begin
            j <= i;
            i <= h;
            h <= g;
            g <= f;
            f <= e;
            e <= d;
            d <= c;
            c <= b;
            b <= a;
            a <= data_in;
            count  <= count + 1;
        end
        if (count == 10) begin         
            done <= 1;
            data_out <= {b,c,d,e,f,g,h,i};
            count <= 0;
        end
        else begin
            done <= 0;
        end
    end
endmodule                          
