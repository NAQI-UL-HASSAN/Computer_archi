module fifo(
    input  logic       clk,
    input  logic       reset,
    input  logic [7:0] data,
    input  logic       write_en,
    input  logic       get,
    input  logic       frame_error,
    input  logic       overrun_error,
    output logic [4:0] count,
    output logic [9:0] out_data,
    output logic       rd_flag,
    output logic       RXFF
);

           logic [9:0] FIFO [15:0];
           logic [3:0] getI;
           logic [3:0] putI;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            getI     <= 0;
            putI     <= 0;
            count    <= 0;
            RXFF     <= 0;
        //    out_data <= 10'b0;
        end
        else begin
            if ((write_en) && (!RXFF)) begin
                FIFO[putI] <= {frame_error, overrun_error, data};
                putI       <= putI  + 1;
                count      <= count + 1;
            end
            else if ((get)) begin
                getI      <= getI  + 1;
                count     <= count - 1;
            end

            if (count == 16) begin
                RXFF   <= 1;
            end
            else begin
                RXFF <= 0;
            end

            if (count != 0) begin
                rd_flag <= 1;
            end
            else begin
                rd_flag <= 0;
            end
        end
    end

    always_comb begin
        if (get) begin
            out_data  = FIFO[getI];
        end
    end
endmodule