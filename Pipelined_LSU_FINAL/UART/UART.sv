module UART(
    input  var logic       clk,
    input  var logic       rst,
    input  var logic [7:0] uart_in,
    input  var logic       busy,
    input  var logic       Get,
    input  var logic [15:0]brd,
    output var logic       Fe,
    output var logic       Ff,
    output var logic       rd_flag,
    output var logic       done_t,
    output var logic       tx_clk,
    output var logic       rx_clk,
    output var logic [9:0] uart_out,
    output var logic       Rxff,
    output var logic       done_r
);

wire logic       tr_data;
wire logic [7:0] df_t;
wire logic [7:0] fs_t;
wire logic       en_w;
wire logic       en_read;
wire logic [4:0] Count;
wire logic       Load;
wire logic       Shift;
wire logic [3:0] count_rep;
wire logic [3:0] count_bits;
wire logic [7:0] sf_r;
wire logic [9:0] fd_r;
wire logic       en_f;

transmitter_top transmitter_top (.clk        (clk),
                                 .rst        (rst),
                                 .data_in    (uart_in),
                                 .busy       (busy),
                                 .out_tx     (tr_data),
                                 .data_df    (df_t),
                                 .data_fs    (fs_t),
                                 .en_w       (en_w),
                                 .en_read    (en_read),
                                 .Count      (Count),
                                 .Load       (Load),
                                 .Fe         (Fe),
                                 .Ff         (Ff),
                                 .Done       (done_t),
                                 .tx_clk     (tx_clk),
                                 .brd        (brd)
                                 );

receiver_top    receiver_top    (.clk        (clk),
                                 .rst        (rst),
                                 .Get        (Get),
                                 .Rx_input   (tr_data),
                                 .Shift      (Shift),
                                 .baud_clk   (rx_clk),
                                 .count_rep  (count_rep),
                                 .rd_flag    (rd_flag),
                                 .count_bits (count_bits),
                                 .sf_data    (sf_r),
                                 .fd_data    (fd_r),
                                 .Done       (done_r),
                                 .en_f       (en_f),
                                 .Rx_out     (uart_out),
                                 .Rxff       (Rxff),
                                 .brd        (brd)
                                 );

endmodule