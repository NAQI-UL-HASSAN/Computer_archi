module FIFO_t(
    input  logic       clk,
    input  logic       reset,
    input  logic [7:0] input_data,
    input  logic       write_en,
    input  logic       read_en,
    output logic [7:0] output_data,
    output logic       fifo_empty,
    output logic [4:0] count,
    output logic       fifo_full
);

           logic [7:0] FIFO [15:0];
           logic [3:0] getI;
           logic [3:0] putI;
      //     logic [4:0] count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            getI        <= 0;
            putI        <= 0;
            count       <= 0;
            fifo_empty  <= 1;
            fifo_full   <= 0;
            output_data <= 8'b0;
        end
        else begin
            if ((write_en) && (!fifo_full) && (input_data != 8'b0)) begin
                FIFO[putI] <= input_data;
                putI       <= putI  + 1;
                count      <= count + 1;
            end
            else if ((read_en) && (count > 0)) begin
                output_data <= FIFO[getI];
                getI        <= getI  + 1;
                count       <= count - 1;
            end

            if (count == 0) begin
                fifo_empty  <= 1;
            end
            else begin
                fifo_empty <= 0;
            end
            if (count == 16) begin
                fifo_full   <= 1;
            end
            else begin
                fifo_full <= 0;
            end
        end
    end
endmodule