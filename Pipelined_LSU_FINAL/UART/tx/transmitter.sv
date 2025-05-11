module transmitter (
    input  logic clk,
    input  logic rst,
    input  logic [7:0] data_in,
    input  logic       busy,
    input  logic       write_en,
    input  logic       read_en,
    input  logic       load,
    input  logic [15:0]brd,
    output logic       fifo_empty,
    output logic       fifo_full,
    output logic       done,
    output logic       tx_clk,     // for simulation
    output logic [7:0] data_df,
    output logic [7:0] data_fs,
    output logic [4:0] count,
    output logic       out_tx      
);
           

data_register_t  data_register_t  (.clk         (clk),
                               .reset       (rst),
                               .data_in     (data_in),
                               .busy        (busy),
                               .data_out    (data_df)
                             );

FIFO_t           FIFO_t           (.clk         (clk),
                               .reset       (rst),
                               .input_data  (data_df),
                               .write_en    (write_en),
                               .read_en     (read_en),
                               .count       (count),
                               .output_data (data_fs),
                               .fifo_empty  (fifo_empty),
                               .fifo_full   (fifo_full)
                                );

shift_register_t shift_register_t (.clk         (clk),
                               .reset       (rst),
                               .baud_clk_16 (tx_clk),
                               .data_in     (data_fs),
                               .load        (load),
                               .data_out    (out_tx),
                               .done        (done),
                               .brd         (brd)
                               );
endmodule